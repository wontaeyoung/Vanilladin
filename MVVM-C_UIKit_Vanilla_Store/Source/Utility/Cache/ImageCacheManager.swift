import UIKit

final class ImageCacheManager {
    
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
            selector: #selector(removeAllObjects),
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
    
    func getObject(for key: String) -> UIImage? {
        let cacheKey: NSString = .init(string: key)
        
        let cachedImage: UIImage? = ImageCacheManager.shared.cache.object(forKey: cacheKey)
        
        return cachedImage
    }
    
    func setObject(
        _ object: UIImage,
        for key: String
    ) {
        let cacheKey: NSString = .init(string: key)
        
        ImageCacheManager.shared.cache.setObject(object, forKey: cacheKey)
    }
    
    func removeObject(for key: String) {
        let cacheKey: NSString = .init(string: key)
        ImageCacheManager.shared.cache.removeObject(forKey: cacheKey)
    }
    
    @objc func removeAllObjects() {
        ImageCacheManager.shared.cache.removeAllObjects()
    }
}
