import UIKit

class LoginViewController: UIViewController {
    struct Dependency {
        let viewModel: LoginViewModel
    }
    
    // MARK: - Properties
    
    let viewModel: LoginViewModel
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
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
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
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
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
    private lazy var autoLoginCheckButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSelected = isCheckedAutoLogin
        button.setImage(UIImage(systemName: "checkmark.square")?.withTintColor(.systemBrown, renderingMode: .alwaysOriginal), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square.fill")?.withTintColor(.systemBrown, renderingMode: .alwaysOriginal), for: .selected)
        button.addTarget(self, action: #selector(autoLoginCheckButtonDidTap), for: .touchUpInside)
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
    }
    
    // MARK: Configure
    
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
        
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailPasswordStackView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 10),
            emailPasswordStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            emailPasswordStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            autoLoginStackView.topAnchor.constraint(equalTo: emailPasswordStackView.bottomAnchor, constant: 20),
            autoLoginStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            autoLoginStackView.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: autoLoginStackView.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signUpStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func loginButtonDidTap() {
        viewModel.logIn(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    @objc
    private func signUpButtonDidTap() {
        viewModel.signUp()
    }
    
    @objc
    private func autoLoginCheckButtonDidTap() {
        autoLoginCheckButton.isSelected = !autoLoginCheckButton.isSelected
        viewModel.autoLogin(isChecked: autoLoginCheckButton.isSelected)
    }
}
