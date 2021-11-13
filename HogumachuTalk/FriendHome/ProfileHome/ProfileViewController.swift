import UIKit

class ProfileViewController: UIViewController {
    struct Dependency {
        let viewModel: ProfileViewModel
    }
    // MARK: - Properties
    
    let viewModel: ProfileViewModel
    private let profileStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 3
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.cornerCurve = .continuous
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        return label
    }()
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.textColor = .white
        return label
    }()
    private let chatStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    private lazy var chatButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "message.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(chatButtonDidTap), for: .touchUpInside)
        return button
    }()
    private let chatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1:1 채팅"
        label.textColor = .white
        return label
    }()
    private let editStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "pencil")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(chatButtonDidTap), for: .touchUpInside)
        return button
    }()
    private let editLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "프로필 편집"
        label.textColor = .white
        return label
    }()
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let headerBarStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        return stack
    }()
    private let headerLeftBarStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        return stack
    }()
    private let headerRightBarStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        return stack
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        return button
    }()
    private let footerStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 30
        return stack
    }()
    
    // MARK: Lifecycle
    
    init(dependency: Dependency) {
        self.viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureUI()
    }
    
    // MARK: Configure
    
    private func configureUI() {
        view.backgroundColor = .darkGray
        view.addSubview(backgroundImageView)
        view.addSubview(profileStackView)
        view.addSubview(headerBarStackView)
        view.addSubview(footerStackView)
        
        profileStackView.addArrangedSubview(profileImageView)
        profileStackView.addArrangedSubview(userNameLabel)
        profileStackView.addArrangedSubview(statusLabel)
        
        chatStackView.addArrangedSubview(chatButton)
        chatStackView.addArrangedSubview(chatLabel)
        
        editStackView.addArrangedSubview(editButton)
        editStackView.addArrangedSubview(editLabel)
        
        headerBarStackView.addArrangedSubview(headerLeftBarStackView)
        headerBarStackView.addArrangedSubview(headerRightBarStackView)
        
        footerStackView.addArrangedSubview(chatStackView)
        footerStackView.addArrangedSubview(editStackView)
        
        headerLeftBarStackView.addArrangedSubview(backButton)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerBarStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerBarStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerBarStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            profileStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileStackView.bottomAnchor.constraint(equalTo: chatStackView.topAnchor, constant: -30),
            
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            
            footerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            footerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            chatButton.widthAnchor.constraint(equalToConstant: 30),
            chatButton.heightAnchor.constraint(equalToConstant: 30),
            
            editButton.widthAnchor.constraint(equalToConstant: 30),
            editButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func bindViewModel() {
        // TODO: - Image Set Up
//        profileImageView.image = viewModel.user.profileImageURL
//        backgroundImageView.image = viewModel.user
        userNameLabel.text = viewModel.user.userName
        statusLabel.text = viewModel.user.status
    }
    
    // MARK: - Actions
    
    @objc
    private func chatButtonDidTap() {
        viewModel.chat()
    }
    
    @objc
    private func backButtonDidTap() {
        viewModel.back()
    }
}
