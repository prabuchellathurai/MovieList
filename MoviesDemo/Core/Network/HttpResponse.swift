import Foundation

enum HttpError: Error {
    case NetworkFail, DataError
}

enum HttpResponse<T> {
    case success(T?), failed(Error)
}
