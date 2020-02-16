import Foundation
import UIKit

protocol IMovieListViewModel {
    var title: String { get }
    var movie: [Movie] { get }
    var progress: Variable<HttpProgress> { get }
    func objectAtIndex(index: Int) -> MovieListCellViewModel
    func loadMoviesList()
    func cancelAllDownloads()
}

class MovieListViewModel: IMovieListViewModel {
    
    private let repository: IMovieListRepository = MovieListRepository()
    private var movies: Movies?
    private let progressUpdate: Variable<HttpProgress> = Variable<HttpProgress>()
    private let imageFetch: ImageFetcher = ImageFetcher()
    
    subscript(index: Int) -> Movie {
        get {
            return movie[index]
        }
    }
    
    var title: String {
        return NSLocalizedString("Movies", comment: "Name")
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
        
        let cellViewModel = MovieListCellViewModel(movie: movie[index], fetch: imageFetch)
        return cellViewModel
    }
    
    func loadMoviesList() {
        progress.value = .Start
        repository.loadMovies { [weak self] (response: HttpResponse<Movies>) in
            switch response {
            case .success(let movies):
                self?.movies = movies
                self?.progress.value = .End
            case .failed(let _):
                self?.progress.value = .ErrorResponse
            }
        }
    }
    
    func cancelAllDownloads() {
        imageFetch.cancelAll()
    }

}
