import UIKit

class ProfileTableViewCell: UITableViewCell {
    static let identifier = "ProfileTableViewCell"
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.cornerCurve = .continuous
        imageView.contentMode = .scaleAspectFit
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
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),
            
            labelStackView.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 5),
            labelStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            labelStackView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -5)
        ])
    }
    
    func setItem(item: User) {
//        profileImageView.image = item.profileImageURL
        userNameLabel.text = item.userName
        statusLabel.text = item.status
        
    }
}
