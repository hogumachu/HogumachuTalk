import Foundation

class ProfileViewModel: ViewModelType {
    struct Dependency {
        let user: User
    }
    var coordinator: Coordinator?
    let user: User
    
    init(dependency: Dependency) {
        self.user = dependency.user
    }
    
    func chat() {
        // TODO: - chatButton Action
        
        // Dismiss -> Push ViewController
//        coordinator?.dismiss()
    }
    
    func back() {
        coordinator?.dismiss()
    }
}
