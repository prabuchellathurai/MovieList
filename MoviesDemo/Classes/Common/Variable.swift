import Foundation

class Variable<T> {
    
    typealias Notifier = (T) -> Void
    
    var value: T? {
        didSet {
           performNotification()
        }
    }
    
    var notify:  Notifier? {
        didSet {
            
        }
    }
    
    private func performNotification() {
        guard let object = value else {
            return
        }
        notify?(object)
    }

}
