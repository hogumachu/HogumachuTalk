import UIKit
import RxSwift
import SnapKit

class FriendViewController: UIViewController {
    struct Dependency {
        let viewModel: FriendViewModel
    }
    
    // MARK: - Properties
    
    let viewModel: FriendViewModel
    private let disposeBag = DisposeBag()
    private let profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    private let searchBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: _magnifyingglass, style: .plain, target: self, action: nil)
        return barButton
    }()
    private let addFriendBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: _personPlus, style: .plain, target: self, action: nil)
        return barButton
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
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        // TODO: - NavigationItem Set Up
        navigationItem.title = "친구"
        navigationItem.setRightBarButtonItems([addFriendBarButton, searchBarButton], animated: false)
    }
    
    private func bindViewModel() {
        viewModel.friendList
            .bind(to: profileTableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
        
        profileTableView.rx.itemSelected
            .bind(
                with: viewModel,
                onNext: { vm, indexPath in vm.itemSelected(indexPath) }
            )
            .disposed(by: disposeBag)
        
        searchBarButton.rx.tap
            .bind(
                with: viewModel,
                onNext: { vm, _ in vm.search() }
            )
            .disposed(by: disposeBag)
        
        addFriendBarButton.rx.tap
            .bind(
                with: viewModel,
                onNext: { vm, _ in vm.emailSearch() }
            )
            .disposed(by: disposeBag)
    }
    
    private func setUpTableView() {
        _ = profileTableView.rx.setDelegate(self)
        profileTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        profileTableView.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.identifier)
    }
}

extension FriendViewController: UIScrollViewDelegate {} 
