class LoginViewModel: UserStorableViewModelType {
    struct Dependency {
        let coordinator: Coordinator
        let storage: FirebaseUserStorageType
    }
    
    // MARK: - Properties
    
    let coordinator: Coordinator
    let storage: FirebaseUserStorageType
    private var loading = false
    
    // MARK: - Initialize
    
    init(depedency: Dependency) {
        self.coordinator = depedency.coordinator
        self.storage = depedency.storage
    }
    
    // MARK: - Helper
    func logIn(email: String, password: String) {
        if loading {
            return
        }
        
        loading = true
        
        if email.isEmpty || password.isEmpty {
            AlertView.show("텍스트를 모두 채워야 합니다")
            loading = false
            return
        }
        
        FirebaseImp.shared.signIn(email: email, password: password) { [weak self] result in
            self?.loading = false
            switch result {
            case .success(_):
                self?.storage.setCurrentUser()
                self?.coordinator.signIn()
            case .failure(let err):
                if let err = err as? FirebaseError {
                    AlertView.show(err.rawValue)
                } else {
                    AlertView.show(err.localizedDescription)
                }
                
            }
        }
    }
    
    func signUp() {
        coordinator.signUp()
    }
    
    func autoLogin(isChecked: Bool) {
        saveAutoLoginLocal(isChecked)
    }
}
