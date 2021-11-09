import UIKit

class SettingViewController: UIViewController {
    struct Dependency {
        let viewModel: SettingViewModel
    }
    var coordinator: Coordinator?
    let viewModel: SettingViewModel
    
    init(dependency: Dependency) {
        self.viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
