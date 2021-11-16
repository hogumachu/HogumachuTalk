class SettingViewModel: ViewModelType {
    var coordinator: Coordinator?
    private var loading = false
    
    func logOut() {
        if loading {
            return
        }

        loading = true
        
        FirebaseImp.shared.signOut { [weak self] result in
            self?.loading = false
            switch result {
            case .success(_):
                self?.coordinator?.signOut()
            case .failure(let err):
                print(err)
            }
        }
    }
}
