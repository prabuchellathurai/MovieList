import Foundation

protocol IMovieListRepository {
    func loadMovies(block: @escaping (Movies?) -> Void)
}

class MovieListRepository: IMovieListRepository {
    
    func loadMovies(block: @escaping (Movies?) -> Void) {
        let configuration = HttpConfiguration(url: AppConfiguration.baseUrl, method: .Post)
        let service = NetworkConnection()
        service.request(request: configuration) { (response: Movies?) in
            block(response)
        }
    }
    
}
