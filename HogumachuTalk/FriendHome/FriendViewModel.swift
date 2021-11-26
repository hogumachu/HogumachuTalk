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
    
    // MARK: - Initialize
    
    init(dependency: Dependency) {
        self.coordinator = dependency.coordinator
        self.storage = dependency.storage
    }
    
    // TODO: - TableView DataSource
    
    let dataSource: RxTableViewSectionedAnimatedDataSource<UserSectionModel> = {
        let ds = RxTableViewSectionedAnimatedDataSource<UserSectionModel> { dataSource, tableView, indexPath, user -> UITableViewCell in
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as! ProfileTableViewCell
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
    
    var friendList: Observable<[UserSectionModel]> {
        return storage.setionModelObservable
    }
    
    // TODO: - IndexPath 별 다른 ModelSelect Action
    func modelSelected(_ user: User) {
        coordinator.profile()
    }
}
