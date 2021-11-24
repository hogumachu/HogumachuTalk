import Foundation
import UIKit

class ProfileViewModel: ViewModelType {
    struct Dependency {
        let coordinator: Coordinator
        let storage: FirebaseUserStorageType
    }
    
    // MARK: - Properties
    
    let coordinator: Coordinator
    let storage: FirebaseUserStorageType
    
    // MARK: - Initialize
    
    init(dependency: Dependency) {
        self.coordinator = dependency.coordinator
        self.storage = dependency.storage
    }
    
    // MARK: - Helper
    
    func chat() {
        // TODO: - chatButton Action
        // Dismiss -> Push ViewController
        
        print("ChatButtonDidTap")
    }
    
    func back(userName: String?, status: String?) {
        storage.updateUserName(name: userName ?? "")
        storage.updateUserStatus(status: status ?? "")
        
        coordinator.dismiss(nil, animated: true)
    }
    
    func profileImageSetUp(_ viewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate & UIViewController, isEditMode: Bool, type: ProfileImageType) {
        if isEditMode {
            coordinator.imagePickerVC(viewController, .photoLibrary)
        } else {
            let url = storage.loadImageURL(type: type)
            
            ImageLoader.shared.loadImage(url) { [weak self] image in
                self?.coordinator.imageVC(viewController, image: image, animated: true)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        coordinator.dismiss(picker, animated: true)
    }
    
    func imagePickerControllerDidFinish(_ picker: UIImagePickerController, info: [UIImagePickerController.InfoKey: Any], type: ProfileImageType, completion: @escaping (UIImage?) -> Void) {
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
                self?.storage.updateUserProfileImageURL(url: link)
            case .background:
                self?.storage.updateUserBackgroundImageURL(url: link)
            }
        }
        
        saveFileLocal(
            file: image.jpegData(compressionQuality: 1.0)! as NSData,
            fileName: User.currentId,
            pathPrefix: type.rawValue
        )
        
        completion(image)
        coordinator.dismiss(picker, animated: true)
    }
}
