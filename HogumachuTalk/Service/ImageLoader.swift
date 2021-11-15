import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private init() {}
    
    func loadImage(_ url: String, completion: @escaping (UIImage?) -> Void) {
        guard !url.isEmpty, let downLoadURL = URL(string: url) else {
            return
        }
        
        DispatchQueue.global().async {
            do {
                
                let data = try Data(contentsOf: downLoadURL)
                let image = UIImage(data: data)
                
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
