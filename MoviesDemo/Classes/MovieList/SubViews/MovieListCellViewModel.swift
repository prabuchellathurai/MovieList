import Foundation
import UIKit

protocol IMovieListCellViewModel {
    var name: String { get }
    var genre: String { get }
    var posterImage: UIImage? { get }
    var plot: String { get }
    var update : ((UIImage?) -> Void)? { get set}
}

class MovieListCellViewModel: IMovieListCellViewModel {
    
    private let movie: Movie
    var update : ((UIImage?) -> Void)?
    private var imageFetch: ImageFetcher
    
    init(movie: Movie = Movie(), fetch: ImageFetcher = ImageFetcher()) {
        self.movie = movie
        imageFetch = fetch
        downloadImage()
    }
    
    var name: String {
        return movie.name
    }
    
    var genre: String {
        return movie.genre
    }
    
    var plot: String {
        return movie.plot ?? ""
    }
    
    var posterImage: UIImage? {
        guard let poster = imageFetch.image(url: movie.poster) else {
            return UIImage.placeHolder
        }
        
        return poster
    }
    
    private func downloadImage() {
        guard let poster = movie.poster else {
            return
        }
        
        imageFetch.download(url: poster) { [weak self] (image: UIImage?) in
            self?.update?(image)
        }
    }
    
}
