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
            FirebaseImp.shared.updateUser(user: user, userName: userName, status: status)
        }
        coordinator?.dismiss()
    }
    
    func loadUser() {
        FirebaseImp.shared.loadUser()
        
        if let currentUser = User.currentUser {
            user = currentUser
        }
    }
    
    func profileImageSetUp(_ viewController: UIViewController, _ picker: UIImagePickerController, isEditMode: Bool) {
        if isEditMode {
            picker.sourceType = .photoLibrary
            viewController.present(picker, animated: true, completion: nil)
        } else {
            // TODO: Image View 전체 화면으로 전환
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidFinish(_ picker: UIImagePickerController, info: [UIImagePickerController.InfoKey: Any]) -> UIImage? {
        // TODO: Image View Save (Local, Firebase)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
        return image
    }
}
