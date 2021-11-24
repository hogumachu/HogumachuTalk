import UIKit
import SnapKit

class AlertView: UIView {
    static let shared = AlertView()
    
    // MARK: - Properties
    
    private let alertView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.cornerCurve = .continuous
        return view
    }()
    private let alertLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBrown
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(white: 0, alpha: 0.4)
        return view
    }()
    private lazy var cancelBackgroundButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
        button.backgroundColor = .clear
        return button
    }()
    
    // MARK: - Lifecycle
    
    convenience private init() {
        self.init(frame: UIScreen.main.bounds)
    }
    required internal init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override private init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - Helper
    
    class func show(_ text: String = "") {
        DispatchQueue.main.async {
            shared.showAlert(text)
        }
    }
    
    private func showAlert(_ text: String = "") {
        alertLabel.text = text
        setUI()
    }
    
    private func setUI() {
        alpha = 0
        addSubview(backgroundView)
        addSubview(alertView)
        addSubview(alertLabel)
        addSubview(cancelBackgroundButton)
        
        backgroundView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(300)
        }
        
        alertLabel.snp.makeConstraints {
            $0.center.equalTo(alertView)
            $0.leading.greaterThanOrEqualTo(alertView.snp.leading).offset(10)
            $0.trailing.lessThanOrEqualTo(alertView.snp.trailing).offset(-10)
        }
        
        cancelBackgroundButton.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        let mainWindow = UIApplication.shared.windows.first ?? UIWindow()
        mainWindow.addSubview(self)
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    // MARK: - Cancel Action
    
    @objc
    private func cancelButtonDidTap() {
        self.removeFromSuperview()
    }
}
