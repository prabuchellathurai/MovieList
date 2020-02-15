import Foundation
import UIKit

protocol IMovieListCellViewModel {
    var name: String { get }
    var genre: String { get }
    var posterImage: UIImage? { get }
    var update : ((UIImage?) -> Void)? { get set}
}

class MovieListCellViewModel: IMovieListCellViewModel {
    
    private let movie: Movie
    var update : ((UIImage?) -> Void)?
    var imageCacheBlock : ((UIImage?) -> Void)?
    
    init(movie: Movie = Movie()) {
        self.movie = movie
    }
    
    var name: String {
        return movie.name
    }
    
    var genre: String {
        return movie.genre
    }
    
    var posterImage: UIImage? {
        guard let poster = movie.poster else {
            return UIImage.placeHolder
        }
        ImageDownload().download(url: poster) { [weak self] (image: UIImage?) in
            self?.imageCacheBlock?(image)
            self?.update?(image)
        }
        return UIImage.placeHolder
    }
    
}
