import Foundation
import Firebase
import UIKit

class FirebaseImp {
    // 싱글톤 패턴 사용
    // init 막고 shared 로 이용
    static let shared = FirebaseImp()
    private init() {}
    
    // MARK: - SignIn
    
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
    
    // MARK: - SignOut
    
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
                            print("이메일 인증 에러:", #function, verificationError)
                        }
                    }
                    
                    let user = User(id: authResult.user.uid,
                                    userName: userName,
                                    email: email,
                                    profileImageURL: "",
                                    backgroundImageURL: ""
                    )
                    
                    saveUserLocal(user)
                    
                    FirebaseImp.shared.uploadUserFirebase(user) { result in
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
    
    // MARK: - Download
    
    func downloadUserFirebase(id: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        DispatchQueue.global().async {
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
    }
    
    func downloadCurrentUser() {
        downloadUserFirebase(id: User.currentId) { result in
            switch result {
            case .success(_):
                print("User Load 완료", #function)
            case .failure(let err):
                print("User Load 실패", #function, err.localizedDescription)
            }
        }
    }
    
    func downloadImage(url: String, pathPrefix: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        DispatchQueue.global().async {
            let fileName = fileName(fileURL: url)
            
            let exist = pathPrefix.isEmpty ?
            existsFileInFileManager(fileName: fileName) :
            existsFileInFileManager(fileName: fileName, pathPrefix: pathPrefix)
            
            let contentOfFile = pathPrefix.isEmpty ?
            documentDirectoryURLPath(fileName: fileName) :
            documentDirectoryURLPath(fileName: fileName, pathPrefix: pathPrefix)
            
            if exist, let image = UIImage(contentsOfFile: contentOfFile) {
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            } else {
                ImageLoader.shared.loadImage(url) { image in
                    if let image = image {
                        // Local 에 Image 저장 (원본 데이터로 저장함)
                        saveFileLocal(
                            file: image.jpegData(compressionQuality: 1.0)! as NSData,
                            fileName: User.currentId, pathPrefix: pathPrefix
                        )
                        
                        DispatchQueue.main.async {
                            completion(.success(image))
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(.failure(FirebaseError.download))
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Upload
    
    func uploadUserFirebase(_ user: User, completion: @escaping (Result<Bool, Error>) -> Void) {
        DispatchQueue.global().async {
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
    }
    
    func uploadUser(_ user: User) {
        saveUserLocal(user)
        uploadUserFirebase(user) { result in
            switch result {
            case .success(_):
                print("User 업데이트 완료")
            case .failure(let err):
                print("User 업데이트 실패:", err.localizedDescription)
            }
        }
    }
    
    func uploadImage(image: UIImage, directory: String, completion: @escaping (_ link: String) -> Void) {
        DispatchQueue.global().async {
            let reference = Storage.storage().reference(forURL: fireStorageFileURL).child(directory)
            guard let data = image.jpegData(compressionQuality: 0.5) else {
                print("Image Convert Error", #function)
                return
            }
            var task: StorageUploadTask!
            
            task = reference.putData(data, metadata: nil, completion: { metaData, error in
                task.removeAllObservers()
                
                if let error = error {
                    print("Upload Error (Image)", error.localizedDescription)
                    return
                }
                
                reference.downloadURL { url, error in
                    guard let url = url else {
                        DispatchQueue.main.async {
                            completion("")
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completion(url.absoluteString)
                    }
                }
                
            })
            
            task.observe(.progress) { snapshot in
                print(CGFloat(snapshot.progress!.completedUnitCount / snapshot.progress!.totalUnitCount))
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
