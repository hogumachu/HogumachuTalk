import UIKit
import SnapKit

class FriendViewController: UIViewController {
    struct Dependency {
        let viewModel: FriendViewModel
    }
    
    // MARK: - Properties
    
    let viewModel: FriendViewModel
    private let profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
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
        setUpTableView()
        configureNavigationBar()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadUser()
        profileTableView.reloadData()
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(profileTableView)
        
        profileTableView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view)
        }
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "친구"
    }
    
    private func setUpTableView() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        profileTableView.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.identifier)
    }
}

extension FriendViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewDidSelect(tableView, indexPath: indexPath)
    }
}

extension FriendViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.tableViewCell(tableView, indexPath: indexPath)
    }
}
