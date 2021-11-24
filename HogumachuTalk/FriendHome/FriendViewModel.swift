import UIKit

class FriendViewModel: ViewModelType {
    struct Dependency {
        let coordinator: Coordinator
    }
    
    // MARK: - Properties
    
    let coordinator: Coordinator
    
    
    // MARK: - Initialize
    
    init(dependency: Dependency) {
        self.coordinator = dependency.coordinator
    }
    
    // MARK: - TableView
    
    func tableViewNumberOfRowsInSection(section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            // TODO: - Load Friends Count
            return 0
        }
    }
    
    func tableViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let item = User.currentUser!
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
            cell.setItem(item: item)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as! FriendTableViewCell
            
            return cell
        }
    }
    
    func tableViewDidSelect(_ tableView: UITableView, indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: false)
            coordinator.profile()
        }
    }
}
