import Foundation

protocol INetworkConnection {
    associatedtype type: Codable
    func request(request: HttpConfiguration)
    func cancel()
}

class NetworkConnection {
    
    private var task: URLSessionDataTask?
    
    func request<T: Codable>(request: HttpConfiguration, block: @escaping (HttpResponse<T>) -> Void) {
        guard let url = URL(string: request.url) else {
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                let errorResponse = HttpResponse<T>.failed(HttpError.DataError)
                block(errorResponse)
                return
            }
            let parser = NetworkParser<T>(data: data)
            let result = parser.parse()
            block(HttpResponse<T>.success(result))
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
    
}
