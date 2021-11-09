import UIKit

class SignUpViewController: UIViewController {
    struct Dependency {
        let viewModel: SignUpViewModel
    }
    
    // MARK: - Properties
    
    var coordinator: Coordinator?
    let viewModel: SignUpViewModel
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "회원가입"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .systemBrown
        return label
    }()
    private let wrapStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        return stack
    }()
    private let emailStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 3
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBrown
        label.text = "E-Mail"
        return label
    }()
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "이메일"
        return textField
    }()
    private let passwordStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 3
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBrown
        label.text = "Password"
        return label
    }()
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true
        return textField
    }()
    private let confirmStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 3
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBrown
        label.text = "Password Confirm"
        return label
    }()
    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "비밀번호 확인"
        textField.isSecureTextEntry = true
        return textField
    }()
    private let userNameStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 3
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBrown
        label.text = "User Name"
        return label
    }()
    private let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "이름"
        return textField
    }()
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" 회원가입 ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBrown
        button.layer.cornerCurve = .continuous
        button.layer.cornerRadius = 8
        button.addTarget(self , action: #selector(signUpButtonDidTap), for: .touchUpInside)
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
    }
    
    
    // MARK: - Configure
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(signUpLabel)
        view.addSubview(wrapStackView)
        view.addSubview(signUpButton)
        
        wrapStackView.addArrangedSubview(emailStackView)
        wrapStackView.addArrangedSubview(passwordStackView)
        wrapStackView.addArrangedSubview(confirmStackView)
        wrapStackView.addArrangedSubview(userNameStackView)
        
        emailStackView.addArrangedSubview(emailLabel)
        emailStackView.addArrangedSubview(emailTextField)
        
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextField)
        
        confirmStackView.addArrangedSubview(confirmPasswordLabel)
        confirmStackView.addArrangedSubview(confirmPasswordTextField)
        
        userNameStackView.addArrangedSubview(userNameLabel)
        userNameStackView.addArrangedSubview(userNameTextField)
        
        NSLayoutConstraint.activate([
            signUpLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            wrapStackView.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 10),
            wrapStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            wrapStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            signUpButton.topAnchor.constraint(equalTo: wrapStackView.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Action
    
    @objc
    private func signUpButtonDidTap() {
        // TODO: - SignUp Method
        print("Sign Up Button Did Tap")
        
        let user = User(id: emailTextField.text!,
                        userName: userNameTextField.text!,
                        email: emailTextField.text!,
                        profileImageURL: ""
        )
        
        print(user)
    }
}
