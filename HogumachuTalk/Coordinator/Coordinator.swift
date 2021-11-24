import UIKit

class Coordinator {
    struct Dependency {
        let storage: FirebaseUserStorageType
        
        let mainNavigationController: UINavigationController
        let loginViewControllerFactory: (LoginViewController.Dependency) -> LoginViewController
        let signUpViewControllerFactory: (SignUpViewController.Dependency) -> SignUpViewController
        
        let homeTabBarController: UITabBarController
        
        let friendNavigationController: UINavigationController
        let friendViewControllerFactory: (FriendViewController.Dependency) -> FriendViewController
        let profileViewControllerFactory: (ProfileViewController.Dependency) -> ProfileViewController
        let profileImageViewControllerFactory: (ProfileImageViewController.Dependency) -> ProfileImageViewController
        let imagePickerControllerFactory: () -> UIImagePickerController
        
        let chatNavigationController: UINavigationController
        let chatViewControllerFactory: (ChatViewController.Dependency) -> ChatViewController
        
        let settingNavigationController: UINavigationController
        let settingViewControllerFactory: (SettingViewController.Dependency) -> SettingViewController
    }
    
    let storage: FirebaseUserStorageType
    
    let mainNavigationController: UINavigationController
    let loginViewControllerFactory: (LoginViewController.Dependency) -> LoginViewController
    let signUpViewControllerFactory: (SignUpViewController.Dependency) -> SignUpViewController
    
    let homeTabBarController: UITabBarController
    
    let friendNavigationController: UINavigationController
    let friendViewControllerFactory: (FriendViewController.Dependency) -> FriendViewController
    let profileViewControllerFactory: (ProfileViewController.Dependency) -> ProfileViewController
    let profileImageViewControllerFactory: (ProfileImageViewController.Dependency) -> ProfileImageViewController
    let imagePickerControllerFactory: () -> UIImagePickerController
    
    let chatNavigationController: UINavigationController
    let chatViewControllerFactory: (ChatViewController.Dependency) -> ChatViewController
    
    let settingNavigationController: UINavigationController
    let settingViewControllerFactory: (SettingViewController.Dependency) -> SettingViewController
    
    init(dependency: Dependency) {
        self.storage = dependency.storage
        
        self.mainNavigationController = dependency.mainNavigationController
        self.loginViewControllerFactory = dependency.loginViewControllerFactory
        self.signUpViewControllerFactory = dependency.signUpViewControllerFactory
        
        self.homeTabBarController = dependency.homeTabBarController
        
        self.friendNavigationController = dependency.friendNavigationController
        self.friendViewControllerFactory = dependency.friendViewControllerFactory
        self.profileViewControllerFactory = dependency.profileViewControllerFactory
        self.profileImageViewControllerFactory = dependency.profileImageViewControllerFactory
        self.imagePickerControllerFactory = dependency.imagePickerControllerFactory
        
        self.chatNavigationController = dependency.chatNavigationController
        self.chatViewControllerFactory = dependency.chatViewControllerFactory
        
        self.settingNavigationController = dependency.settingNavigationController
        self.settingViewControllerFactory = dependency.settingViewControllerFactory
    }
}

// MARK: - Scene Transition Methods

extension Coordinator {
    private var currentViewController: UIViewController {
       if let currentVC = homeTabBarController.selectedViewController, let lastVC = currentVC.children.last {
           return lastVC
       }
       return homeTabBarController.selectedViewController ?? homeTabBarController
    }
    
    private var currentNavigationController: UINavigationController? {
        return homeTabBarController.selectedViewController as? UINavigationController
    }
    
    func start() {
        let vc = loginViewControllerFactory(.init(viewModel: .init(depedency: .init(coordinator: self))))
        
        mainNavigationController.setViewControllers([vc], animated: false)
        
        // 만약 User 데이터를 갖고 있고 자동 로그인이 체크되어있으면
        if User.currentUser != nil && isCheckedAutoLogin {
            // 자동으로 로그인함
            signIn()
        }
    }
    
    func signUp() {
        let vc = signUpViewControllerFactory(.init(viewModel: .init(dependency: .init(coordinator: self))))
        
        mainNavigationController.present(vc, animated: true, completion: nil)
    }
    
    func signIn() {
        let friendVC = friendViewControllerFactory(.init(viewModel: .init(dependency: .init(coordinator: self))))
        friendVC.tabBarItem = UITabBarItem(title: "",
                                            image: UIImage(systemName: "person"),
                                            selectedImage: UIImage(systemName: "person.fill")
        )
        friendNavigationController.setViewControllers([friendVC], animated: false)
        
        let chatVC = chatViewControllerFactory(.init(viewModel: .init(dependency: .init(coordinator: self))))
        
        chatVC.tabBarItem = UITabBarItem(title: "",
                                         image: UIImage(systemName: "message"),
                                         selectedImage: UIImage(systemName: "message.fill")
        )
        chatNavigationController.setViewControllers([chatVC], animated: false)
        
        let settingVC = settingViewControllerFactory(.init(viewModel: .init(dependency: .init(coordinator: self))))
        
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
    
    func profile() {
        let vc = profileViewControllerFactory(.init(viewModel: .init(dependency: .init(coordinator: self, storage: storage))))
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
    
    func pop(animated: Bool) {
        currentNavigationController?.popViewController(animated: animated)
    }
    
    func imagePickerVC(_ viewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate & UIViewController,_ sourceType: UIImagePickerController.SourceType) {
        let vc = imagePickerControllerFactory()
        vc.delegate = viewController.self
        vc.sourceType = sourceType
        
        viewController.present(vc, animated: true, completion: nil)
    }
    
    func imageVC(_ viewController: UIViewController, image: UIImage?, animated: Bool) {
        let vc = profileImageViewControllerFactory(.init(image: image))
        
        viewController.present(vc, animated: animated, completion: nil)
    }
}
