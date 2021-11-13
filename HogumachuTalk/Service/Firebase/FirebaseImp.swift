import Foundation
import Firebase

class FirebaseImp {
    // 싱글톤 패턴 사용
    // init 막고 shared 로 이용
    static let shared = FirebaseImp()
    private init() {}
    
    // MARK: - Login
    
    func signIn(email: String, password: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        Auth.auth()
            .signIn(withEmail: email, password: password) { authResult , error in
                // 에러 없고, 인증 데이터 있고, 인증 데이터의 유저의 이메일이 인증을 하였을 때
                if error == nil, let authResult = authResult, authResult.user.isEmailVerified {
                    // Firebase 로 User 데이터 다운
                    FirebaseImp.shared.downloadUserFirebase(id: authResult.user.uid) { result in
                        switch result {
                        case .success(_):
                            completion(.success(true))
                        case .failure(let err):
                            completion(.failure(err))
                        }
                    }
                } else {
                    completion(.failure(error ?? FirebaseError.emailVerified)) // 에러가 nil 이면 아마 이메일 인증 때문일 듯 ?? -> 나중에 좀 더 확실히 하기
                }
            }
    }
    
    // MARK: - Logout
    
    func signOut(completion: @escaping(Result<Bool, Error>) -> Void) {
        do {
            try Auth.auth().signOut() // 로그아웃 실행
            UserDefaults.standard.removeObject(forKey: currentUserKey) // UserDefaults 에 저장된 값도 지우기
            UserDefaults.standard.synchronize()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - SignUp
    
    func signUp(email: String, password: String, userName: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth()
            .createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                } else if let authResult = authResult {
                    authResult.user.sendEmailVerification { error in
                        if let verificationError = error?.localizedDescription, !verificationError.isEmpty {
                            print("이메일 인증 에러:", verificationError)
                        }
                    }
                    
                    let user = User(id: authResult.user.uid,
                                    userName: userName,
                                    email: email,
                                    profileImageURL: ""
                    )
                    
                    saveUserLocal(user)
                    
                    FirebaseImp.shared.saveUserFirebase(user) { result in
                        switch result {
                        case .success(_):
                            completion(.success(true))
                        case .failure(let err):
                            completion(.failure(err))
                        }
                    }
                } else {
                    completion(.failure(FirebaseError.unknown))
                }
            }
    }
    
    // MARK: - Save
    
    func saveUserFirebase(_ user: User, completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            try Firestore.firestore()
                .collection(firestoreCollectionUser)
                .document(user.id)
                .setData(from: user)
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - Download
    
    func downloadUserFirebase(id: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Firestore.firestore()
            .collection(firestoreCollectionUser)
            .document(id)
            .getDocument { document, error in
                guard let document = document else {
                    completion(.failure(FirebaseError.emptyDocument))
                    return
                }
                
                do {
                    let user = try document.data(as: User.self)
                    
                    guard let user = user else {
                        completion(.failure(FirebaseError.download))
                        return
                    }
                    saveUserLocal(user)
                    completion(.success(true))
                } catch {
                    completion(.failure(error))
                }
            }
    }
    
    func loadUser() {
        downloadUserFirebase(id: User.currentId) { result in
            switch result {
            case .success(_):
                print("User Load 완료")
            case .failure(let err):
                print("User Load 실패:", err.localizedDescription)
            }
        }
    }
    
    // MARK: - Update
    
    func updateUser(user: User, userName: String, status: String) {
        var user = user
        user.userName = userName
        user.status = status
        
        saveUserLocal(user)
        saveUserFirebase(user) { result in
            switch result {
            case .success(_):
                print("User 업데이트 완료")
            case .failure(let err):
                print("User 업데이트 실패:", err.localizedDescription)
            }
        }
    }
}

enum FirebaseError: Error {
    case emailVerified
    case unknown
    case emptyDocument
    case download
}
