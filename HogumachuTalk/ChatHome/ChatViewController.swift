import UIKit
import SnapKit

class ChatViewController: UIViewController {
    struct Dependency {
        let viewModel: ChatViewModel
    }
    
    // MARK: - Properties
    
    let viewModel: ChatViewModel
    private let chatRoomTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        configureNavigationBar()
        setUpTableView()
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(chatRoomTableView)
        
        chatRoomTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "채팅"
    }
    
    private func setUpTableView() {
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        
        chatRoomTableView.register(ChatRoomTableViewCell.self, forCellReuseIdentifier: ChatRoomTableViewCell.identifier)
    }
}

// MARK: TableView Delegate

extension ChatViewController: UITableViewDelegate {
    
}

// MARK: - TableView DataSource

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.tableViewCell(tableView, indexPath: indexPath)
    }
}
