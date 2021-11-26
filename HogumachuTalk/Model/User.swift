import Foundation
import Firebase
import FirebaseFirestoreSwift
import RxDataSources

struct User: Codable, Equatable, IdentifiableType {
    typealias Identity = String
    
    let identity: String
    var userName: String
    var email: String
    var profileImageURL: String
    var backgroundImageURL: String
    var status: String = "안녕하세요. 반갑습니다"
    
    enum CodingKeys: String, CodingKey {
        case identity = "id"
        case userName
        case email
        case profileImageURL
        case backgroundImageURL
        case status
    }
}

extension User {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.identity == rhs.identity
    }
    
    static var currentId: String {
        return Auth.auth().currentUser!.uid
    }
    
    static var currentUser: User? {
        if Auth.auth().currentUser != nil {
            if let jsonData = UserDefaults.standard.data(forKey: _currentUserKey) {
                do {
                    let object = try JSONDecoder().decode(User.self, from: jsonData)
                    return object
                } catch {
                    print("Error !!!", #function, error.localizedDescription)
                    return nil
                }
            }
        }
        
        return nil
    }
    
    static let empty = User.init(identity: "", userName: "", email: "", profileImageURL: "", backgroundImageURL: "")
}
