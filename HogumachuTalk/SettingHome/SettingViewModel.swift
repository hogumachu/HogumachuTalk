class SettingViewModel: ViewModelType {
    struct Dependency {
        let coordinator: Coordinator
    }
    
    // MARK: - Properties
    
    var coordinator: Coordinator
    private var loading = false
    
    // MARK: - Initialize
    
    init(dependency: Dependency) {
        self.coordinator = dependency.coordinator
    }
    
    // MARK: - Helper
    
    func logOut() {
        if loading {
            return
        }

        loading = true
        
        FirebaseImp.shared.signOut { [weak self] result in
            self?.loading = false
            switch result {
            case .success(_):
                self?.coordinator.signOut()
            case .failure(let err):
                print(err)
            }
        }
    }
}
