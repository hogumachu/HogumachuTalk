import UIKit

class Coordinator {
    struct Dependency {
        let mainNavigationController: UINavigationController
        let loginViewControllerFactory: () -> LoginViewController
        let signUpViewControllerFactory: () -> SignUpViewController
        
        let homeTabBarController: UITabBarController
        
        let friendNavigationController: UINavigationController
        let friendViewControllerFactory: () -> FriendViewController
        
        let chatNavigationController: UINavigationController
        let chatViewControllerFactory: () -> ChatViewController
        
        let settingNavigationController: UINavigationController
        let settingViewControllerFactory: () -> SettingViewController
    }
    
    let mainNavigationController: UINavigationController
    let loginViewControllerFactory: () -> LoginViewController
    let signUpViewControllerFactory: () -> SignUpViewController
    
    let homeTabBarController: UITabBarController
    
    let friendNavigationController: UINavigationController
    let friendViewControllerFactory: () -> FriendViewController
    
    let chatNavigationController: UINavigationController
    let chatViewControllerFactory: () -> ChatViewController
    
    let settingNavigationController: UINavigationController
    let settingViewControllerFactory: () -> SettingViewController
    
    init(dependency: Dependency) {
        self.mainNavigationController = dependency.mainNavigationController
        self.loginViewControllerFactory = dependency.loginViewControllerFactory
        self.signUpViewControllerFactory = dependency.signUpViewControllerFactory
        
        self.homeTabBarController = dependency.homeTabBarController
        
        self.friendNavigationController = dependency.friendNavigationController
        self.friendViewControllerFactory = dependency.friendViewControllerFactory
        
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
        vc.viewModel.coordinator = self
        
        mainNavigationController.setViewControllers([vc], animated: false)
        
        if User.currentUser != nil && isCheckedAutoLogin {
            signIn()
        }
    }
    
    func signUp() {
        let vc = signUpViewControllerFactory()
        vc.viewModel.coordinator = self
        
        mainNavigationController.present(vc, animated: true, completion: nil)
    }
    
    func signIn() {
        let friendVC = friendViewControllerFactory()
        friendVC.viewModel.coordinator = self
        friendVC.tabBarItem = UITabBarItem(title: "친구",
                                            image: UIImage(systemName: "person"),
                                            selectedImage: UIImage(systemName: "person.fill")
        )
        friendNavigationController.setViewControllers([friendVC], animated: false)
        
        let chatVC = chatViewControllerFactory()
        chatVC.viewModel.coordinator = self
        chatVC.tabBarItem = UITabBarItem(title: "채팅",
                                         image: UIImage(systemName: "quote.bubble"),
                                         selectedImage: UIImage(systemName: "quote.bubble.fill")
        )
        chatNavigationController.setViewControllers([chatVC], animated: false)
        
        let settingVC = settingViewControllerFactory()
        settingVC.viewModel.coordinator = self
        settingVC.tabBarItem = UITabBarItem(title: "설정",
                                            image: UIImage(systemName: "gearshape"),
                                            selectedImage: UIImage(systemName: "gearshape.fill")
        )
        settingNavigationController.setViewControllers([settingVC], animated: false)
        
        homeTabBarController.setViewControllers(
            [
                friendNavigationController,
                chatNavigationController,
                settingNavigationController
            ],
            animated: false
        )
        
        mainNavigationController.pushViewController(homeTabBarController, animated: true)
    }
    
    func signOut() {
        mainNavigationController.popViewController(animated: true)
    }
    
    // TODO: - Scene Enum 만들어서 진행, Method명 변경
    
    private func someSceneChage() {
        guard let currentNavigationController = homeTabBarController.selectedViewController else {
            return
        }
        
        switch currentNavigationController {
        case friendNavigationController:
            print("Friend")
        case chatNavigationController:
            print("Chat")
        case settingNavigationController:
            print("Setting")
        default:
            print("No")
        }
    }
}
