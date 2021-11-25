import UIKit

class FriendViewModel: ViewModelType {
    struct Dependency {
        let coordinator: Coordinator
    }
    
    // MARK: - Properties
    
    let coordinator: Coordinator
    let mock: [User] = [
        .init(id: "Test1", userName: "Test1", email: "Test1@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test2", userName: "Test2", email: "Test2@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test3", userName: "Test3", email: "Test3@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test4", userName: "Test4", email: "Test4@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test5", userName: "Test5", email: "Test5@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test6", userName: "Test6", email: "Test6@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test7", userName: "Test7", email: "Test7@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test8", userName: "Test8", email: "Test85@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test9", userName: "Test9", email: "Test9@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test10", userName: "Test10", email: "Test10@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test11", userName: "Test11", email: "Test11@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test12", userName: "Test12", email: "Test12@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test13", userName: "Test13", email: "Test13@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test14", userName: "Test14", email: "Test14@Test.com", profileImageURL: "", backgroundImageURL: "")
    ]
    
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
            return mock.count
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
            cell.setItem(item: mock[indexPath.row])
            return cell
        }
    }
    
    func tableViewDidSelect(_ tableView: UITableView, indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: false)
            coordinator.profile()
        }
    }
    
    func tableViewHeader(section: Int) -> String? {
        switch section {
        case 1:
            return "친구 \(mock.count)"
        default:
            return nil
        }
    }
}
