import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private init() {}
    private var imageCache: [String: UIImage] = [:]
    
    
    func loadImage(_ url: String, completion: @escaping (UIImage?) -> Void) {
        guard !url.isEmpty, let downLoadURL = URL(string: url) else {
            return
        }
        
        if imageCache[url] != nil {
            completion(imageCache[url]!)
            return
        }
        
        DispatchQueue.global().async {
            do {
                
                let data = try Data(contentsOf: downLoadURL)
                let image = UIImage(data: data)
                
                if let image = image {
                    self.imageCache[url] = image
                }
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
