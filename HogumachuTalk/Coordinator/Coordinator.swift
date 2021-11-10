import UIKit

class Coordinator {
    struct Dependency {
        let mainNavigationController: UINavigationController
        let loginViewControllerFactory: () -> LoginViewController
        let signUpViewControllerFactory: () -> SignUpViewController
        
        let homeTabBarController: UITabBarController
        
        let profileNavigationController: UINavigationController
        let profileViewControllerFactory: () -> ProfileViewController
        
        let chatNavigationController: UINavigationController
        let chatViewControllerFactory: () -> ChatViewController
        
        let settingNavigationController: UINavigationController
        let settingViewControllerFactory: () -> SettingViewController
    }
    
    let mainNavigationController: UINavigationController
    let loginViewControllerFactory: () -> LoginViewController
    let signUpViewControllerFactory: () -> SignUpViewController
    
    let homeTabBarController: UITabBarController
    
    let profileNavigationController: UINavigationController
    let profileViewControllerFactory: () -> ProfileViewController
    
    let chatNavigationController: UINavigationController
    let chatViewControllerFactory: () -> ChatViewController
    
    let settingNavigationController: UINavigationController
    let settingViewControllerFactory: () -> SettingViewController
    
    init(dependency: Dependency) {
        self.mainNavigationController = dependency.mainNavigationController
        self.loginViewControllerFactory = dependency.loginViewControllerFactory
        self.signUpViewControllerFactory = dependency.signUpViewControllerFactory
        
        self.homeTabBarController = dependency.homeTabBarController
        
        self.profileNavigationController = dependency.profileNavigationController
        self.profileViewControllerFactory = dependency.profileViewControllerFactory
        
        self.chatNavigationController = dependency.chatNavigationController
        self.chatViewControllerFactory = dependency.chatViewControllerFactory
        
        self.settingNavigationController = dependency.settingNavigationController
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
    
    func signIn() {
        let profileVC = profileViewControllerFactory()
        profileVC.coordinator = self
        profileVC.tabBarItem = UITabBarItem(title: "프로필",
                                            image: UIImage(systemName: "person"),
                                            selectedImage: UIImage(systemName: "person.fill")
        )
        profileNavigationController.setViewControllers([profileVC], animated: false)
        
        let chatVC = chatViewControllerFactory()
        chatVC.coordinator = self
        chatVC.tabBarItem = UITabBarItem(title: "채팅",
                                         image: UIImage(systemName: "quote.bubble"),
                                         selectedImage: UIImage(systemName: "quote.bubble.fill")
        )
        chatNavigationController.setViewControllers([chatVC], animated: false)
        
        let settingVC = settingViewControllerFactory()
        settingVC.coordinator = self
        settingVC.tabBarItem = UITabBarItem(title: "설정",
                                            image: UIImage(systemName: "gearshape"),
                                            selectedImage: UIImage(systemName: "gearshape.fill")
        )
        settingNavigationController.setViewControllers([settingVC], animated: false)
        
        homeTabBarController.setViewControllers(
            [
                profileNavigationController,
                chatNavigationController,
                settingNavigationController
            ],
            animated: false
        )
        
        mainNavigationController.pushViewController(homeTabBarController, animated: true)
    }
}
