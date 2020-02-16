import Foundation
import UIKit

class FetchHttpRequest {
    
    private var downloadTask: URLSessionDataTask?
    
    func request(url: String, block: @escaping (UIImage?) -> Void) {
        let trimedUrl = url.replacingOccurrences(of: " ", with: "")
        guard let imageURL = URL(string: trimedUrl) else {
            return
        }
        
        downloadTask = URLSession.shared.dataTask(with: imageURL) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let imgData = data else {
                block(nil)
                return
            }
            let image = UIImage(data: imgData)
            block(image)
        }
        downloadTask?.resume()
    }
    
    func cancel() {
        downloadTask?.cancel()
    }
}
