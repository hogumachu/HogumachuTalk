class SettingViewModel: ViewModelType {
    var coordinator: Coordinator?
    
    func logOut() {
        FirebaseImp.shared.signOut { [weak self] result in
            switch result {
            case .success(_):
                self?.coordinator?.signOut()
            case .failure(let err):
                print(err)
            }
        }
    }
}
