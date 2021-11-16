import UIKit
import SnapKit

class SettingViewController: UIViewController {
    struct Dependency {
        let viewModel: SettingViewModel
    }
    
    // MARK: - Properties
    
    let viewModel: SettingViewModel
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(logOutButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    init(dependency: Dependency) {
        self.viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(logOutButton)
        
        // TODO: - Layout
        logOutButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "설정"
    }
    
    // MARK: - Action
    
    @objc
    private func logOutButtonDidTap() {
        viewModel.logOut()
    }
}
