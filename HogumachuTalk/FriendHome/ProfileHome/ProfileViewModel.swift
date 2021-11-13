import Foundation

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
}
