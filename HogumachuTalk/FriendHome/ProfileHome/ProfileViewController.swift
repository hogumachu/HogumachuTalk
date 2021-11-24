import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    struct Dependency {
        let viewModel: ProfileViewModel
    }
    
    // MARK: - Properties
    
    let viewModel: ProfileViewModel
    private let disposeBag = DisposeBag()
    private var imageType: ProfileImageType = .profile
    private let profileStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 3
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.cornerCurve = .continuous
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        let gesture = UITapGestureRecognizer(target: self, action: #selector(profileImageViewDidTap))
        imageView.addGestureRecognizer(gesture)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    private let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 20, weight: .medium)
        textField.textColor = .white
        textField.isEnabled = false
        return textField
    }()
    private let statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 15, weight: .thin)
        textField.textColor = .white
        textField.isEnabled = false
        return textField
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
    private let chatButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(_messageFill, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
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
    private let editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(_pencilCircle, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    private let editLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "프로필 편집"
        label.textColor = .white
        return label
    }()
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleAspectFill
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backgroundImageViewDidTap))
        imageView.addGestureRecognizer(gesture)
        imageView.isUserInteractionEnabled = true
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
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(_xMark, for: .normal)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNotificationObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotificationObserver()
    }
    
    // MARK: Configure
    
    private func configureUI() {
        view.backgroundColor = .darkGray
        view.addSubview(backgroundImageView)
        view.addSubview(profileStackView)
        view.addSubview(headerBarStackView)
        view.addSubview(footerStackView)
        
        profileStackView.addArrangedSubview(profileImageView)
        profileStackView.addArrangedSubview(userNameTextField)
        profileStackView.addArrangedSubview(statusTextField)
        
        chatStackView.addArrangedSubview(chatButton)
        chatStackView.addArrangedSubview(chatLabel)
        
        editStackView.addArrangedSubview(editButton)
        editStackView.addArrangedSubview(editLabel)
        
        headerBarStackView.addArrangedSubview(headerLeftBarStackView)
        headerBarStackView.addArrangedSubview(headerRightBarStackView)
        
        footerStackView.addArrangedSubview(chatStackView)
        footerStackView.addArrangedSubview(editStackView)
        
        headerLeftBarStackView.addArrangedSubview(backButton)
        
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        headerBarStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        profileStackView.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.bottom.equalTo(chatStackView.snp.top).offset(-30)
        }
        
        profileImageView.snp.makeConstraints {
            $0.height.width.equalTo(80)
        }
        
        footerStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
        
        chatButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        
        editButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
    }
    
    private func bindViewModel() {
        viewModel.storage.userObservable()
            .subscribe(onNext: { [weak self] user in
                FirebaseImp.shared.downloadImage(url: user.profileImageURL, pathPrefix: ProfileImageType.profile.rawValue) { result in
                    switch result {
                    case .success(let image):
                        self?.profileImageView.image = image
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }
                
                FirebaseImp.shared.downloadImage(url: user.backgroundImageURL, pathPrefix: ProfileImageType.background.rawValue) { result in
                    switch result {
                    case .success(let image):
                        self?.backgroundImageView.image = image
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }
                
                self?.userNameTextField.text = user.userName
                self?.statusTextField.text = user.status
            })
            .disposed(by: disposeBag)
        
        chatButton.rx.tap
            .bind(onNext: viewModel.chat)
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .bind(onNext: back)
            .disposed(by: disposeBag)
        
        editButton.rx.tap
            .bind(onNext: edit)
            .disposed(by: disposeBag)
        
    }
    
    // MARK: - Actions
    
    @objc
    private func profileImageViewDidTap() {
        imageType = .profile
        viewModel.profileImageSetUp(self, isEditMode: userNameTextField.isEnabled, type: .profile)
    }
    
    @objc
    private func backgroundImageViewDidTap() {
        imageType = .background
        viewModel.profileImageSetUp(self, isEditMode: userNameTextField.isEnabled, type: .background)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let height = keyboardFrame.cgRectValue.height - view.safeAreaInsets.bottom
            
            UIView.animate(withDuration: 0.3) { [unowned self] in
                footerStackView.snp.updateConstraints {
                    $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30 - height)
                }
                view.layoutIfNeeded()
            }
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) { [unowned self] in
            footerStackView.snp.updateConstraints {
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            }
            view.layoutIfNeeded()
        }
    }
    
    // MARK: - Helper
    
    private func back() {
        viewModel.back(userName: userNameTextField.text, status: statusTextField.text)
    }
    
    private func edit() {
        userNameTextField.isEnabled = !userNameTextField.isEnabled
        statusTextField.isEnabled = !statusTextField.isEnabled
        changeEditProperties(userNameTextField.isEnabled)
    }
    
    private func changeEditProperties(_ isEditMode: Bool) {
        UIView.animate(withDuration: 0.3) { [unowned self] in
            if isEditMode {
                editLabel.text = "편집 모드"
                editButton.setImage(_pencilCircleFill, for: .normal)
            } else {
                editLabel.text = "프로필 편집"
                editButton.setImage(_pencilCircle, for: .normal)
            }
            view.layoutIfNeeded()
        }
    }
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        viewModel.imagePickerControllerDidFinish(picker, info: info, type: imageType) { [weak self] image in
            switch self?.imageType {
            case .profile:
                self?.profileImageView.image = image
            case .background:
                self?.backgroundImageView.image = image
            case .none:
                return
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewModel.imagePickerControllerDidCancel(picker)
    }
}
