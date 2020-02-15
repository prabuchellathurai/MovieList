import Foundation

enum HttpMethod {
    case Post, Get, Put, Delete
}

class HttpConfiguration {
    let url: String
    let method: HttpMethod
    
    init(url: String, method: HttpMethod) {
        self.url = url
        self.method = method
    }
}
