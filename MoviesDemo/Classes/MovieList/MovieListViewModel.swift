import Foundation
import UIKit

protocol IMovieListViewModel {
    var title: String { get }
    var movie: [Movie] { get }
    var progress: Variable<HttpProgress> { get }
    func objectAtIndex(index: Int) -> MovieListCellViewModel
    func loadMoviesList()
}

class MovieListViewModel: IMovieListViewModel {
    
    private let repository: IMovieListRepository = MovieListRepository()
    private var movies: Movies?
    private let progressUpdate: Variable<HttpProgress> = Variable<HttpProgress>()
    
    subscript(index: Int) -> Movie {
        get {
            return movie[index]
        }
    }
    
    var title: String {
        return "Movies"
    }
    
    var movie: [Movie] {
        return movies?.movies ?? []
    }
    
    var progress: Variable<HttpProgress> {
        return progressUpdate
    }
    
    func objectAtIndex(index: Int) -> MovieListCellViewModel {
        
        guard index < movie.count else {
            fatalError("Index out of range")
        }
        
        let cellViewModel = MovieListCellViewModel(movie: movie[index])
        cellViewModel.imageCacheBlock = { (image: UIImage?) in
            
        }
        return cellViewModel
    }
    
    func loadMoviesList() {
        progress.value = .Start
        repository.loadMovies { [weak self] in
            self?.movies = $0
            self?.progress.value = .End
        }
    }

}
