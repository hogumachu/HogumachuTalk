import UIKit

class Coordinator {
    struct Dependency {
        let mainNavigationController: UINavigationController
        let loginViewControllerFactory: () -> LoginViewController
        let signUpViewControllerFactory: () -> SignUpViewController
        
        let homeTabBarController: UITabBarController
        
        let friendNavigationController: UINavigationController
        let friendViewControllerFactory: () -> FriendViewController
        let profileViewControllerFactory: (User) -> ProfileViewController
        let imagePickerControllerFactory: () -> UIImagePickerController
        
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
    let profileViewControllerFactory: (User) -> ProfileViewController
    let imagePickerControllerFactory: () -> UIImagePickerController
    
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
        self.profileViewControllerFactory = dependency.profileViewControllerFactory
        self.imagePickerControllerFactory = dependency.imagePickerControllerFactory
        
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
        
        // 만약 User 데이터를 갖고 있고 자동 로그인이 체크되어있으면
        if User.currentUser != nil && isCheckedAutoLogin {
            // 자동으로 로그인함
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
        friendVC.tabBarItem = UITabBarItem(title: "",
                                            image: UIImage(systemName: "person"),
                                            selectedImage: UIImage(systemName: "person.fill")
        )
        friendNavigationController.setViewControllers([friendVC], animated: false)
        
        let chatVC = chatViewControllerFactory()
        chatVC.viewModel.coordinator = self
        chatVC.tabBarItem = UITabBarItem(title: "",
                                         image: UIImage(systemName: "message"),
                                         selectedImage: UIImage(systemName: "message.fill")
        )
        chatNavigationController.setViewControllers([chatVC], animated: false)
        
        let settingVC = settingViewControllerFactory()
        settingVC.viewModel.coordinator = self
        settingVC.tabBarItem = UITabBarItem(title: "",
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
    
    func profile(user: User) {
        let vc = profileViewControllerFactory(user)
        vc.viewModel.coordinator = self
        vc.modalPresentationStyle = .fullScreen
        homeTabBarController.present(vc, animated: true, completion: nil)
    }
    
    func dismiss(_ viewController: UIViewController?, animated: Bool) {
        if let vc = viewController {
            vc.dismiss(animated: animated)
        } else {
            currentViewController.dismiss(animated: animated)
        }
    }
    
    func imagePickerVC(_ viewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate & UIViewController,_ sourceType: UIImagePickerController.SourceType) {
        let vc = imagePickerControllerFactory()
        vc.delegate = viewController.self
        vc.sourceType = sourceType
        
        viewController.present(vc, animated: true, completion: nil)
    }
    
    // TODO: - Scene Enum 만들어서 진행, Method명 변경
    
     private var currentViewController: UIViewController {
        if let currentVC = homeTabBarController.selectedViewController, let lastVC = currentVC.children.last {
            return lastVC
        }
        return homeTabBarController.selectedViewController ?? homeTabBarController
    }
}
