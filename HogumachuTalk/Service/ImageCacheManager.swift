import UIKit.UIImage

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private init() {}
    
    let imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(_ key: String) -> UIImage? {
        return imageCache.object(forKey: NSString(string: key))
    }
    
    func setImage(_ key: String, image: UIImage) {
        imageCache.setObject(image, forKey: NSString(string: key))
    }
}
