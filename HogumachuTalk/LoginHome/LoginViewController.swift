import UIKit

class LoginViewController: UIViewController {
    struct Dependency {
        let viewModel: LoginViewModel
    }
    var coordinator: Coordinator?
    let viewModel: LoginViewModel
    
    init(dependency: Dependency) {
        self.viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
