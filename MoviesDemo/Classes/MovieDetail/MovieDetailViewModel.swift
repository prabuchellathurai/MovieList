import Foundation
import UIKit

protocol IMovieDetailViewModel {
    var name: String { get }
    var genre: String { get }
    var posterImage: UIImage? { get }
}

class MovieDetailViewModel: IMovieDetailViewModel {
    
    private let movie: Movie
    
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
        return UIImage.placeHolder
    }
}
