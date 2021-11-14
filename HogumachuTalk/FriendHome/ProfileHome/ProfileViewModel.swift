import Foundation
import UIKit

class ProfileViewModel: ViewModelType {
    struct Dependency {
        let user: User
    }
    var coordinator: Coordinator?
    var user: User
    
    init(dependency: Dependency) {
        self.user = dependency.user
    }
    
    func chat() {
        // TODO: - chatButton Action
        
        // Dismiss -> Push ViewController
//        coordinator?.dismiss()
    }
    
    func back(userName: String, status: String) {
        if user.userName != userName || user.status != status {
            user.userName = userName
            user.status = status
            FirebaseImp.shared.uploadUser(user)
        }
        coordinator?.dismiss(nil, animated: true)
    }
    
    func loadUser() {
        FirebaseImp.shared.downloadCurrentUser()
        
        if let currentUser = User.currentUser {
            user = currentUser
        }
    }
    
    func profileImageSetUp(_ viewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate & UIViewController, _ picker: UIImagePickerController, isEditMode: Bool) {
        if isEditMode {
            coordinator?.imagePickerVC(viewController, .photoLibrary)
        } else {
            // TODO: Image View 전체 화면으로 전환
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        coordinator?.dismiss(picker, animated: true)
    }
    
    func imagePickerControllerDidFinish(_ picker: UIImagePickerController, info: [UIImagePickerController.InfoKey: Any], completion: @escaping (UIImage?) -> Void) {
        // TODO: Image View Save (Local, Firebase)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("이미지를 선택할 수 없습니다")
            return
        }
        
        let directory = "ProfileImages/_\(User.currentId).jpg"
        
        
        FirebaseImp.shared.uploadImage(image: image, directory: directory) { [unowned self] link in
            user.profileImageURL = link
            saveUserLocal(user)
            
            FirebaseImp.shared.uploadUser(user)
            FirebaseImp.shared.uploadUserFirebase(user) { result in
                switch result {
                case .success(_):
                    print("이미지 저장 성공")
                case .failure(let err):
                    print("이미지 저장 실패", err.localizedDescription)
                }
            }
        }
        completion(image)
        coordinator?.dismiss(picker, animated: true)
    }
}
