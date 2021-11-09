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
        
        let profileViewControllerFactory: () -> ProfileViewController = {
            return .init(dependency: .init(viewModel: .init()))
        }
        
        let chatViewControllerFactory: () -> ChatViewController = {
            return .init(dependency: .init(viewModel: .init()))
        }
        
        let settingViewControllerFactory: () -> SettingViewController = {
            return .init(dependency: .init(viewModel: .init()))
        }
        return .init(coordinator: .init(dependency: .init(mainNavigationController: mainNavigationController,
                                                          loginViewControllerFactory: loginViewControllerFactory,
                                                          signUpViewControllerFactory: signUpViewControllerFactory,
                                                          profileViewControllerFactory: profileViewControllerFactory,
                                                          chatViewControllerFactory: chatViewControllerFactory,
                                                          settingViewControllerFactory: settingViewControllerFactory
                                                         )))
    }
}
