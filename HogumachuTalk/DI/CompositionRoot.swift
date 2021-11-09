struct AppDependency {
    let coordinator: Coordinator
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let loginViewControllerFactory: () -> LoginViewController = {
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
        return .init(coordinator: .init(dependency: .init(loginViewControllerFactory: loginViewControllerFactory,
                                                          profileViewControllerFactory: profileViewControllerFactory,
                                                          chatViewControllerFactory: chatViewControllerFactory,
                                                          settingViewControllerFactory: settingViewControllerFactory
                                                         )))
    }
}
