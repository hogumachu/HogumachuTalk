import UIKit
import RxSwift
import RxDataSources

typealias UserSectionModel = AnimatableSectionModel<Int, User>

class FriendViewModel: FriendStorableViewModelType {
    struct Dependency {
        let coordinator: Coordinator
        let storage: FirebaseFriendStorageType
    }
    
    // MARK: - Properties
    
    let coordinator: Coordinator
    let storage: FirebaseFriendStorageType
    var friendList: Observable<[UserSectionModel]> {
        return storage.setionModelObservable
    }
    
    // MARK: - Initialize
    
    init(dependency: Dependency) {
        self.coordinator = dependency.coordinator
        self.storage = dependency.storage
    }
    
    // MARK: - TableView DataSource
    
    let dataSource: RxTableViewSectionedAnimatedDataSource<UserSectionModel> = {
        let ds = RxTableViewSectionedAnimatedDataSource<UserSectionModel> { dataSource, tableView, indexPath, user -> UITableViewCell in
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
                cell.setItem(item: user)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as! FriendTableViewCell
                cell.setItem(item: user)
                return cell
            }
        }
        
        return ds
    }()
    
    
    // TODO: - IndexPath 별 다른 ItemSelected Action
    func itemSelected(_ indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            coordinator.profile()
        }
    }
    
    // MARK: - Helper
    
    func search() {
        print("TODO : Use Search View Controller")
        
        coordinator.searchVC()
    }
    
    func emailSearch() {
        coordinator.emailVC()
    }
}
