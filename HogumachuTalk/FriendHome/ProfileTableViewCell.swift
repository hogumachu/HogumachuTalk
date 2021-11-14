import UIKit
import SnapKit

class ProfileTableViewCell: UITableViewCell {
    static let identifier = "ProfileTableViewCell"
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.cornerCurve = .continuous
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray
        return imageView
    }()
    private let labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 2
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        return stack
    }()
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(profileImageView)
        addSubview(labelStackView)
        
        labelStackView.addArrangedSubview(userNameLabel)
        labelStackView.addArrangedSubview(statusLabel)
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-5)
            $0.width.height.equalTo(60)
        }
        
        labelStackView.snp.makeConstraints {
            $0.top.equalTo(profileImageView).offset(5)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalTo(profileImageView.snp.bottom).offset(-5)
        }
    }
    
    func setItem(item: User) {
        ImageLoader.shared.loadImage(item.profileImageURL) { [weak self] image in
            self?.profileImageView.image = image
        }
        
        userNameLabel.text = item.userName
        statusLabel.text = item.status
        
    }
}
