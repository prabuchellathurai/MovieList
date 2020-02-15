import Foundation
import UIKit

class ImageDownload {
    
    private var downloadTask: URLSessionDataTask?
    
    func download(url: String, block: @escaping (UIImage?) -> Void) {
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
