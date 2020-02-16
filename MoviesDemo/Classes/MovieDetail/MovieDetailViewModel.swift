import Foundation
import UIKit

protocol IMovieDetailViewModel {
    var name: String { get }
    var genre: String { get }
    var plot: String { get }
    var posterImage: UIImage? { get }
    var update : ((UIImage?) -> Void)? { get set }
}

class MovieDetailViewModel: IMovieDetailViewModel {
    
    private let movie: Movie
    private let imageFetch: ImageFetcher
    private var poster: UIImage?
    var update : ((UIImage?) -> Void)?
    
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
            self?.poster = image
            self?.update?(image)
        }
    }
    
}
