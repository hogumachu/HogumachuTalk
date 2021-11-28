import UIKit
import RxSwift
import SnapKit

class SearchViewController: UIViewController {
    struct Dependency {
        let viewModel: SearchViewModel
    }

    let viewModel: SearchViewModel
    private let disposeBag = DisposeBag()
    private let searchStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.layer.cornerRadius = 8
        stack.backgroundColor = .systemGray5
        return stack
    }()
    private let searchImageView: UIImageView = {
        let imageView = UIImageView(image: _magnifyingglass)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "검색"
        textField.backgroundColor = .clear
        return textField
    }()
    private let removeTextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(_xMarkCircleFill, for: .normal)
        button.isHidden = true
        return button
    }()
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        return button
    }()
    
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
        
        searchTextField.becomeFirstResponder()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(searchStackView)
        view.addSubview(cancelButton)
        
        searchStackView.addArrangedSubview(searchImageView)
        searchStackView.addArrangedSubview(searchTextField)
        searchStackView.addArrangedSubview(removeTextButton)
        
        searchStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(5)
            $0.trailing.equalTo(cancelButton.snp.leading).offset(-3)
            $0.height.equalTo(50)
        }
        
        searchImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.leading.equalToSuperview().offset(5)
        }
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalTo(searchImageView.snp.trailing).offset(5)
            $0.trailing.equalTo(removeTextButton.snp.leading).offset(-5)
        }
        
        removeTextButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
        }
        
        cancelButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(40)
            $0.centerY.equalTo(searchStackView.snp.centerY)
        }
    }
    
    private func bindViewModel() {
        cancelButton.rx.tap
            .bind(
                with: viewModel,
                onNext: { vm, _ in vm.cancel() }
            )
            .disposed(by: disposeBag)
        
        searchTextField.rx.text
            .bind(
                with: self,
                onNext: { vc, text in vc.searchTextFieldHasText(text) }
            )
            .disposed(by: disposeBag)
        
        removeTextButton.rx.tap
            .bind(
                with: self,
                onNext: { vc, _ in vc.removeTextFieldText() }
            )
            .disposed(by: disposeBag)
    }
    
    // MARK: - Helper
    
    private func searchTextFieldHasText(_ text: String?) {
        guard let text = text else {
            return
        }
        
        if text.isEmpty {
            removeTextButton.isHidden = true
        } else {
            removeTextButton.isHidden = false
        }
    }
    
    private func removeTextFieldText() {
        searchTextField.text = ""
        removeTextButton.isHidden = true
    }
}
