class Coordinator {
    struct Dependency {
        let loginViewControllerFactory: () -> LoginViewController
        let profileViewControllerFactory: () -> ProfileViewController
        let chatViewControllerFactory: () -> ChatViewController
        let settingViewControllerFactory: () -> SettingViewController
    }
    
    let loginViewControllerFactory: () -> LoginViewController
    let profileViewControllerFactory: () -> ProfileViewController
    let chatViewControllerFactory: () -> ChatViewController
    let settingViewControllerFactory: () -> SettingViewController
    
    init(dependency: Dependency) {
        self.loginViewControllerFactory = dependency.loginViewControllerFactory
        self.profileViewControllerFactory = dependency.profileViewControllerFactory
        self.chatViewControllerFactory = dependency.chatViewControllerFactory
        self.settingViewControllerFactory = dependency.settingViewControllerFactory
    }
}

// MARK: - Scene Transition Methods
extension Coordinator {
    
}
