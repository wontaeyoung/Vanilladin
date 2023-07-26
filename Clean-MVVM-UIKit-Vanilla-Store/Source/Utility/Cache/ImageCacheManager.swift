import UIKit

final class ImageCacheManager: CacheManagerInterface {
    typealias ObjectType = UIImage
    
    // MARK: - Stored Property
    static let shared: ImageCacheManager = .init()
    private let cache: NSCache<NSString, UIImage>
    private let memoryWarningNotification: NSNotification.Name
    
    // MARK: - Initializer
    private init() {
        self.cache = .init()
        self.memoryWarningNotification = UIApplication.didReceiveMemoryWarningNotification
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(removeAllObjects()),
            name: memoryWarningNotification,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: memoryWarningNotification,
            object: nil
        )
    }
}
