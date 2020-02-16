import Foundation
import UIKit

protocol IMovieListViewModel {
    var title: String { get }
    var movie: [Movie] { get }
    var progress: Variable<HttpProgress> { get }
    func objectAtIndex(index: Int) -> MovieListCellViewModel
    func loadMoviesList()
    func cancelAllDownloads()
    func move(source: Int, destination: Int)
    subscript(index: Int) -> Movie { get }
    var update : ((UIImage?, Int) -> Void)? { get set}
    func downloadImage(index: Int)
}

class MovieListViewModel: IMovieListViewModel {
    
    private let repository: IMovieListRepository = MovieListRepository()
    private var movies: Movies?
    private let progressUpdate: Variable<HttpProgress> = Variable<HttpProgress>()
    private let imageFetch: ImageFetcher = ImageFetcher()
    var update : ((UIImage?, Int) -> Void)?
    private var images: [Int: UIImage] = [:]
    
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
    
    private func posterImage(index: Int) -> UIImage? {
        guard let posterImage = images[index] else {
            return UIImage.placeHolder
        }
        return posterImage
    }
    
    func objectAtIndex(index: Int) -> MovieListCellViewModel {
        
        guard index < movie.count else {
            fatalError("Index out of range")
        }
        
        let cellViewModel = MovieListCellViewModel(movie: movie[index], image: posterImage(index: index))
        return cellViewModel
    }
    
    func loadMoviesList() {
        progress.value = .Start
        repository.loadMovies { [weak self] (response: HttpResponse<Movies>) in
            switch response {
            case .success(let movies):
                self?.movies = movies
                self?.progress.value = .End
            case .failed(_):
                self?.progress.value = .ErrorResponse
            }
        }
    }
    
    func move(source: Int, destination: Int) {
        let sourceMovie = movies?.movies[source]
        movies?.movies.remove(at: source)
        
        if let selectedMovie = sourceMovie {
            movies?.movies.insert(selectedMovie, at: destination)
        }
    }
    
    func cancelAllDownloads() {
        imageFetch.cancelAll()
    }

    func downloadImage(index: Int) {
        guard !images.keys.contains(index) else {
            return
        }
        
        guard let poster = movie[index].poster else {
            images[index] = UIImage.placeHolder
            return
        }
        
        imageFetch.download(url: poster) { [weak self] (image: UIImage?) in
            self?.images[index] = image
            self?.update?(image, index)
        }
    }
    
}
