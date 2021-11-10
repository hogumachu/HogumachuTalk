import UIKit

class ChatViewController: UIViewController {
    struct Dependency {
        let viewModel: ChatViewModel
    }
    let viewModel: ChatViewModel
    private let chatRoomTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(chatRoomTableView)
        
        NSLayoutConstraint.activate([
            chatRoomTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatRoomTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatRoomTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatRoomTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
