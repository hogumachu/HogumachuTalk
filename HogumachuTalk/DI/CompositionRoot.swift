import UIKit
struct AppDependency {
    let coordinator: Coordinator
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let storage: FirebaseUserStorageType = FirebaseUserStorage()
        let friendStorage: FirebaseFriendStorageType = FirebaseFriendStorage(dependency: .init(userStorage: storage))
        
        let mainNavigationController: UINavigationController = {
            let navi = UINavigationController()
            navi.isNavigationBarHidden = true
            return navi
        }()
        
        let loginViewControllerFactory: (LoginViewController.Dependency) -> LoginViewController = { dependency in
            return .init(dependency: dependency)
        }
        
        let signUpViewControllerFactory: (SignUpViewController.Dependency) -> SignUpViewController = { dependency in
            return .init(dependency: dependency)
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
        
        let friendViewControllerFactory: (FriendViewController.Dependency) -> FriendViewController = { dependency in
            return .init(dependency: dependency)
        }
        
        let profileViewControllerFactory: (ProfileViewController.Dependency) -> ProfileViewController = { dependency in
            return .init(dependency: dependency)
        }
        
        let profileImageViewControllerFactory: (ProfileImageViewController.Dependency) -> ProfileImageViewController = { dependency in
            let vc = ProfileImageViewController(dependency: dependency)
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            
            return vc
        }
        
        let searchViewControllerFactory: (SearchViewController.Dependency) -> SearchViewController = { dependency in
            return .init(dependency: dependency)
        }
        
        let emailSearchViewControllerFactory: (EmailSearchViewController.Dependency) -> EmailSearchViewController = { dependency in
            return .init(dependency: dependency)
        }
        
        let imagePickerControllerFactory: () -> UIImagePickerController = {
            return .init()
        }
        
        let chatNavigationController: UINavigationController = {
            let navi = UINavigationController()
            return navi
        }()
        
        let chatViewControllerFactory: (ChatViewController.Dependency) -> ChatViewController = { dependency in
            return .init(dependency: dependency)
        }
        
        let settingNavigationController: UINavigationController = {
            let navi = UINavigationController()
            return navi
        }()
        
        let settingViewControllerFactory: (SettingViewController.Dependency) -> SettingViewController = { dependency in
            return .init(dependency: dependency)
        }
        
        return .init(
            coordinator:
                    .init(
                        dependency:
                                .init(
                                    storage: storage,
                                    friendStorage: friendStorage,
                                    mainNavigationController: mainNavigationController,
                                    loginViewControllerFactory: loginViewControllerFactory,
                                    signUpViewControllerFactory: signUpViewControllerFactory,
                                    homeTabBarController: homeTabBarController,
                                    friendNavigationController: friendNavigationController,
                                    friendViewControllerFactory: friendViewControllerFactory,
                                    profileViewControllerFactory: profileViewControllerFactory,
                                    profileImageViewControllerFactory: profileImageViewControllerFactory,
                                    searchViewControllerFactory: searchViewControllerFactory,
                                    emailSearchViewControllerFactory: emailSearchViewControllerFactory,
                                    imagePickerControllerFactory: imagePickerControllerFactory,
                                    chatNavigationController: chatNavigationController,
                                    chatViewControllerFactory: chatViewControllerFactory,
                                    settingNavigationController: settingNavigationController,
                                    settingViewControllerFactory: settingViewControllerFactory
                                )
                    )
        )
    }
}
