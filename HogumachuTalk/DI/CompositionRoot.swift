import UIKit
struct AppDependency {
    let coordinator: Coordinator
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let mainNavigationController: UINavigationController = {
            let navi = UINavigationController()
            navi.isNavigationBarHidden = true
            return navi
        }()
        
        let loginViewControllerFactory: () -> LoginViewController = {
            return .init(dependency: .init(viewModel: .init()))
        }
        
        let signUpViewControllerFactory: () -> SignUpViewController = {
            return .init(dependency: .init(viewModel: .init()))
        }
        
        let homeTabBarController: UITabBarController = {
            let tabBarController = UITabBarController()
            tabBarController.tabBar.tintColor = .black
            return tabBarController
        }()
        
        let friendNavigationController: UINavigationController = {
            let navi = UINavigationController()
            return navi
        }()
        
        let friendViewControllerFactory: () -> FriendViewController = {
            return .init(dependency: .init(viewModel: .init()))
        }
        
        let profileViewControllerFactory: (User) -> ProfileViewController = { user in
            return .init(dependency: .init(viewModel: .init(dependency: .init(user: user))))
        }
        
        let profileImageViewControllerFactory: (UIImage?) -> ProfileImageViewController = { image in
            let vc = ProfileImageViewController(dependency: .init(image: image))
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            
            return vc
        }
        
        let imagePickerControllerFactory: () -> UIImagePickerController = {
            return .init()
        }
        
        let chatNavigationController: UINavigationController = {
            let navi = UINavigationController()
            return navi
        }()
        
        let chatViewControllerFactory: () -> ChatViewController = {
            return .init(dependency: .init(viewModel: .init()))
        }
        
        let settingNavigationController: UINavigationController = {
            let navi = UINavigationController()
            return navi
        }()
        
        let settingViewControllerFactory: () -> SettingViewController = {
            return .init(dependency: .init(viewModel: .init()))
        }
        
        return .init(coordinator: .init(dependency: .init(mainNavigationController: mainNavigationController,
                                                          loginViewControllerFactory: loginViewControllerFactory,
                                                          signUpViewControllerFactory: signUpViewControllerFactory,
                                                          homeTabBarController: homeTabBarController,
                                                          friendNavigationController: friendNavigationController,
                                                          friendViewControllerFactory: friendViewControllerFactory,
                                                          profileViewControllerFactory: profileViewControllerFactory,
                                                          profileImageViewControllerFactory: profileImageViewControllerFactory,
                                                          imagePickerControllerFactory: imagePickerControllerFactory,
                                                          chatNavigationController: chatNavigationController,
                                                          chatViewControllerFactory: chatViewControllerFactory,
                                                          settingNavigationController: settingNavigationController,
                                                          settingViewControllerFactory: settingViewControllerFactory
                                                         )))
    }
}
