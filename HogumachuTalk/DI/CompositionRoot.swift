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
            return tabBarController
        }()
        
        let profileNavigationController: UINavigationController = {
            let navi = UINavigationController()
            return navi
        }()
        
        let profileViewControllerFactory: () -> ProfileViewController = {
            return .init(dependency: .init(viewModel: .init()))
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
                                                          profileNavigationController: profileNavigationController,
                                                          profileViewControllerFactory: profileViewControllerFactory,
                                                          chatNavigationController: chatNavigationController,
                                                          chatViewControllerFactory: chatViewControllerFactory,
                                                          settingNavigationController: settingNavigationController,
                                                          settingViewControllerFactory: settingViewControllerFactory
                                                         )))
    }
}
