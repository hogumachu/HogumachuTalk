import UIKit
import SnapKit

class ChatRoomTableViewCell: UITableViewCell {
    static let identifier = "ChatRoomTableViewCell"
    private let chatRoomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    private let chatRoomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let previewContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(chatRoomImageView)
        addSubview(labelStackView)
        addSubview(dateLabel)
        
        labelStackView.addArrangedSubview(chatRoomLabel)
        labelStackView.addArrangedSubview(previewContentLabel)
        
        chatRoomImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.height.equalTo(60)
        }
        
        labelStackView.snp.makeConstraints {
            $0.leading.equalTo(chatRoomImageView.snp.trailing).offset(10)
            $0.top.equalTo(chatRoomImageView).offset(5)
            $0.bottom.equalTo(chatRoomImageView).offset(-5)
            $0.trailing.lessThanOrEqualToSuperview().offset(-60)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(chatRoomImageView).offset(5)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.equalTo(40)
        }
    }
    
    func setItem(item: User) {
        FirebaseImp.shared.downloadImage(url: item.profileImageURL, pathPrefix: ProfileImageType.profile.rawValue) { [weak self] result in
            switch result {
            case .success(let image):
                self?.chatRoomImageView.image = image
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
        chatRoomLabel.text = item.userName
        previewContentLabel.text = item.userName
        dateLabel.text = item.userName
    }
}

