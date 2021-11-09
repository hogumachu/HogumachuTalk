import Foundation
import Firebase

class FirebaseImp {
    // 싱글톤 패턴 사용
    // init 막고 shared 로 이용
    static let shared = FirebaseImp()
    private init() {}
    
    
    // MARK: - Login
    
    func login(email: String, password: String) {
        // TODO: - Login Method
    }
    
    // MARK: - Logout
    
    func logout(completion: @escaping() -> Void) {
        // TODO: - Logout Method
    }
    
    // MARK: - SignUp
    
    func signUp(user: User, completion: @escaping () -> Void) {
        // TODO: - Sign Up Method
    }
    
    // MARK: - Save
    
    func saveUserFirebase(_ user: User) {
        // TODO: - Save User Method
    }
    
    // MARK: - Download
    
    func downloadUserFirebase(id: String) {
        // TODO: - Download Method
    }
}
