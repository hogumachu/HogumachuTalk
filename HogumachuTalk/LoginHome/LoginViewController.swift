import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    struct Dependency {
        let viewModel: LoginViewModel
    }
    
    // MARK: - Properties
    
    let viewModel: LoginViewModel
    private let disposeBag = DisposeBag()
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.text = "HogumachuTalk"
        label.textColor = .systemBrown
        return label
    }()
    private let emailPasswordStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "E-Mail"
        label.textColor = .systemBrown
        return label
    }()
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "이메일"
        textField.borderStyle = . roundedRect
        return textField
    }()
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password"
        label.textColor = .systemBrown
        return label
    }()
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "비밀번호"
        textField.borderStyle = . roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("  로그인  ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBrown
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .heavy)
        button.layer.cornerRadius = 8
        button.layer.cornerCurve = .continuous
        return button
    }()
    private let signUpStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        return stack
    }()
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "아직 회원이 아니신가요?"
        label.textColor = .systemGray
        return label
    }()
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.systemBrown, for: .normal)
        return button
    }()
    private let autoLoginStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 1
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        return stack
    }()
    private let autoLoginCheckButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSelected = isCheckedAutoLogin
        button.setImage(_checkMarkSquare, for: .normal)
        button.setImage(_checkMarkSquareFill, for: .selected)
        return button
    }()
    private let autoLoginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "자동 로그인"
        label.textColor = .systemBrown
        return label
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
        bindViewModel()
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(logoLabel)
        view.addSubview(emailPasswordStackView)
        view.addSubview(autoLoginStackView)
        view.addSubview(loginButton)
        view.addSubview(signUpStackView)
        
        emailPasswordStackView.addArrangedSubview(emailLabel)
        emailPasswordStackView.addArrangedSubview(emailTextField)
        emailPasswordStackView.addArrangedSubview(passwordLabel)
        emailPasswordStackView.addArrangedSubview(passwordTextField)
        
        autoLoginStackView.addArrangedSubview(autoLoginCheckButton)
        autoLoginStackView.addArrangedSubview(autoLoginLabel)
        
        signUpStackView.addArrangedSubview(signUpLabel)
        signUpStackView.addArrangedSubview(signUpButton)
        
        logoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalTo(view)
        }
        
        emailPasswordStackView.snp.makeConstraints {
            $0.top.equalTo(logoLabel.snp.bottom).offset(10)
            $0.leading.equalTo(view).offset(10)
            $0.trailing.equalTo(view).offset(-10)
        }
        
        autoLoginStackView.snp.makeConstraints {
            $0.top.equalTo(emailPasswordStackView.snp.bottom).offset(20)
            $0.leading.equalTo(view).offset(10)
            $0.trailing.equalTo(view.snp.centerX)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(autoLoginStackView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        signUpStackView.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    // MARK: - Bind
    
    private func bindViewModel() {
        loginButton.rx.tap
            .bind(
                with: self,
                onNext: { vc, _ in vc.login() }
            )
            .disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .bind(
                with: viewModel,
                onNext: { vm, _ in vm.signUp() }
            )
            .disposed(by: disposeBag)
        
        autoLoginCheckButton.rx.tap
            .bind(
                with: self,
                onNext: { vc, _ in vc.autoLogin() }
            )
            .disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    
    private func login() {
        viewModel.logIn(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    private func autoLogin() {
        autoLoginCheckButton.isSelected = !autoLoginCheckButton.isSelected
        viewModel.autoLogin(isChecked: autoLoginCheckButton.isSelected)
    }
}

