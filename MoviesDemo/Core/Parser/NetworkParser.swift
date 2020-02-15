import Foundation

class NetworkParser<T: Codable> {
    
    private let data: Data?
    
    init(data: Data?) {
        self.data = data
    }
    
    func parse() -> T? {
        
        guard let responseData = data else {
            return nil
        }
        
        let decode = JSONDecoder()
        do {
            let result = try decode.decode(T.self, from: responseData)
            return result
        } catch {
            return nil
        }
    }
    
}
