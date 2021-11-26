import UIKit

class FriendViewModel: UserStorableViewModelType, FriendStorableViewModelType {
    struct Dependency {
        let coordinator: Coordinator
        let storage: FirebaseUserStorageType
        let friendStorage: FirebaseFriendStorageType
    }
    
    // MARK: - Properties
    
    let coordinator: Coordinator
    let storage: FirebaseUserStorageType
    let friendStorage: FirebaseFriendStorageType
    
    // MARK: - Initialize
    
    init(dependency: Dependency) {
        self.coordinator = dependency.coordinator
        self.storage = dependency.storage
        self.friendStorage = dependency.friendStorage
    }
    
    // TODO: - TableView DataSource
    // Storage, FriendStorage 에 대한 DataSource 생성
    
}
