import Foundation
import Firebase
import FirebaseFirestoreSwift

struct User: Codable, Equatable {
    let id: String
    var userName: String
    var email: String
    var profileImageURL: String
    var status: String = "안녕하세요. 반갑습니다"
}

extension User {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    static var currentId: String {
        return Auth.auth().currentUser!.uid
    }
    
    static var currentUser: User? {
        if Auth.auth().currentUser != nil {
            if let jsonData = UserDefaults.standard.data(forKey: currentUserKey) {
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
}

func saveUserLocal(_ user: User) {
    do {
        let data = try JSONEncoder().encode(user)
        UserDefaults.standard.set(data, forKey: currentUserKey)
    } catch {
        print("Local 에 저장하는데 에러 발생", #function, error.localizedDescription)
    }
}
