import Foundation
import UIKit

protocol IMovieListCellViewModel {
    var name: String { get }
    var genre: String { get }
    var posterImage: UIImage? { get }
    var plot: String { get }
}

class MovieListCellViewModel: IMovieListCellViewModel {
    
    private let movie: Movie
    private var img: UIImage?
    
    init(movie: Movie = Movie(), image: UIImage?) {
        self.movie = movie
        img = image
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
        return img
    }
    
}
