import UIKit
import SnapKit

class ProfileImageViewController: UIViewController {
    struct Dependency {
        let image: UIImage?
    }
    
    // MARK: - Properies
    
    let image: UIImage?
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(_xMark, for: .normal)
        button.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    init(dependency: Dependency) {
        self.image = dependency.image
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
        view.backgroundColor = .black
        view.addSubview(imageView)
        view.addSubview(backButton)
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: - Action
    
    @objc
    private func backButtonDidTap() {
        self.dismiss(animated: true, completion: nil)
    }
}
