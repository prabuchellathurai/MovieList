import Foundation

protocol IMovieListRepository {
    func loadMovies(block: @escaping (HttpResponse<Movies>) -> Void)
}

class MovieListRepository: IMovieListRepository {
    
    func loadMovies(block: @escaping (HttpResponse<Movies>) -> Void) {
        let configuration = HttpConfiguration(url: AppConfiguration.baseUrl, method: .Post)
        let service = NetworkConnection()
        service.request(request: configuration) { (response: HttpResponse<Movies>) in
            block(response)
        }
    }
    
}
