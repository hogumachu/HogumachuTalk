import UIKit

class Coordinator {
    struct Dependency {
        let mainNavigationController: UINavigationController
        let loginViewControllerFactory: () -> LoginViewController
        let signUpViewControllerFactory: () -> SignUpViewController
        let profileViewControllerFactory: () -> ProfileViewController
        let chatViewControllerFactory: () -> ChatViewController
        let settingViewControllerFactory: () -> SettingViewController
    }
    
    let mainNavigationController: UINavigationController
    let loginViewControllerFactory: () -> LoginViewController
    let signUpViewControllerFactory: () -> SignUpViewController
    let profileViewControllerFactory: () -> ProfileViewController
    let chatViewControllerFactory: () -> ChatViewController
    let settingViewControllerFactory: () -> SettingViewController
    
    init(dependency: Dependency) {
        self.mainNavigationController = dependency.mainNavigationController
        self.loginViewControllerFactory = dependency.loginViewControllerFactory
        self.signUpViewControllerFactory = dependency.signUpViewControllerFactory
        self.profileViewControllerFactory = dependency.profileViewControllerFactory
        self.chatViewControllerFactory = dependency.chatViewControllerFactory
        self.settingViewControllerFactory = dependency.settingViewControllerFactory
    }
}

// MARK: - Scene Transition Methods

extension Coordinator {
    func start() {
        let vc = loginViewControllerFactory()
        vc.coordinator = self
        
        mainNavigationController.setViewControllers([vc], animated: false)
    }
    
    func signUp() {
        let vc = signUpViewControllerFactory()
        vc.coordinator = self
        
        mainNavigationController.present(vc, animated: true, completion: nil)
    }
}
