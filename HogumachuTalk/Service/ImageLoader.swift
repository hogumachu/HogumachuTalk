import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private init() {}
    
    func loadImage(_ url: String, completion: @escaping (UIImage?) -> Void) {
        guard !url.isEmpty, let downLoadURL = URL(string: url) else {
            return
        }
        
        if let image = ImageCacheManager.shared.loadImage(url) {
            DispatchQueue.main.async {
                completion(image)
            }
            return
        }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: downLoadURL)
                let image = UIImage(data: data)
                
                guard let image = image else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                ImageCacheManager.shared.setImage(url, image: image)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        
    }
}
