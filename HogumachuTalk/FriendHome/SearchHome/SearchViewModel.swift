class SearchViewModel: FriendStorableViewModelType {
    struct Dependency {
        let coordinator: Coordinator
        let storage: FirebaseFriendStorageType
    }
    
    let coordinator: Coordinator
    let storage: FirebaseFriendStorageType
    
    init(dependency: Dependency) {
        self.coordinator = dependency.coordinator
        self.storage = dependency.storage
    }
    
    
    func cancel() {
        coordinator.pop(from: .main, animated: true)
    }
    
}
