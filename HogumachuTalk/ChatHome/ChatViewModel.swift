import UIKit
class ChatViewModel: ViewModelType {
    var coordinator: Coordinator?
    
    
    func tableViewNumberOfRowsInSection(section: Int) -> Int {
        return 1
    }
    
    func tableViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let item = User.currentUser!
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomTableViewCell.identifier, for: indexPath) as! ChatRoomTableViewCell
            cell.setItem(item: item)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomTableViewCell.identifier, for: indexPath) as! ChatRoomTableViewCell
            return cell
        }
    }
}
