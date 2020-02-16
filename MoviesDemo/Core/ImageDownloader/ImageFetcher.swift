import Foundation
import UIKit

class ImageFetcher {
    
    private var cache: [String: UIImage] = [:]
    private var activeTask: [String] = []
    private var allOperations: [FetchHttpRequest] = []
    private var downloadTask: FetchHttpRequest = FetchHttpRequest()
    
    func download(url: String, block: @escaping (UIImage?) -> Void) {
        
        guard cache[url] == nil else {
            block(cache[url])
            return
        }
        
        guard !activeTask.contains(url) else {
            return
        }
        
        activeTask.append(url)
        let operation = FetchHttpRequest()
        operation.request(url: url) { [weak self] (image: UIImage?) in
            self?.cache[url] = image
            block(image)
        }
        allOperations.append(operation)
    }
    
    func cancelAll() {
        allOperations.forEach { (request: FetchHttpRequest) in
            request.cancel()
        }
    }
    
    func image(url: String?) -> UIImage? {
        
        guard let imgUrl = url else {
            return nil
        }
        
        return cache[imgUrl]
    }
    
}
