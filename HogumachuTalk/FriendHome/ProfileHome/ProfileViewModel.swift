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
    
    func profileImageSetUp(_ viewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate & UIViewController, isEditMode: Bool, type: ProfileImageType) {
        if isEditMode {
            coordinator?.imagePickerVC(viewController, .photoLibrary)
        } else {
            let url = type == .profile ?
            user.profileImageURL :
            user.backgroundImageURL
            
            ImageLoader.shared.loadImage(url) { [weak self] image in
                self?.coordinator?.imageVC(viewController, image: image, animated: true)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        coordinator?.dismiss(picker, animated: true)
    }
    
    func imagePickerControllerDidFinish(_ picker: UIImagePickerController, info: [UIImagePickerController.InfoKey: Any], type: ProfileImageType, completion: @escaping (UIImage?) -> Void) {
        // TODO: Image View Save (Local, Firebase)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("이미지를 선택할 수 없습니다")
            return
        }
        
        
        let directory = type == .profile ?
        "ProfileImages/ProfileImage/_\(User.currentId).jpg" :
        "ProfileImages/BackgroundImage/_\(User.currentId).jpg"
        
        FirebaseImp.shared.uploadImage(image: image, directory: directory) { [weak self] link in
            switch type {
            case .profile:
                self?.user.profileImageURL = link
            case .background:
                self?.user.backgroundImageURL = link
            }
            
            if let user = self?.user {
                saveUserLocal(user)
                FirebaseImp.shared.uploadUser(user)
            }
            
            
        }
        
        saveFileLocal(
            file: image.jpegData(compressionQuality: 1.0)! as NSData,
            fileName: User.currentId,
            pathPrefix: type.rawValue
        )
        completion(image)
        coordinator?.dismiss(picker, animated: true)
    }
}

enum ProfileImageType: String {
    case profile = "Profile"
    case background = "Background"
}
