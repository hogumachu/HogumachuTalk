class LoginViewModel: ViewModelType {
    var coordinator: Coordinator?
    private var loading = false
    
    func logIn(email: String, password: String) {
        if loading {
            return
        }
        
        loading = true
        
        if email.isEmpty || password.isEmpty {
            // TODO: - 텍스트필드 다 채우라는 Alert
            print("텍스트 다 채워라잉")
            
            AlertView.show("텍스트를 모두 채워야 합니다")
            loading = false
            return
        }
        
        FirebaseImp.shared.signIn(email: email,
                                  password: password) { [weak self] result in
            self?.loading = false
            switch result {
            case .success(_):
                self?.coordinator?.signIn()
            case .failure(let err):
                // TODO: - 에러에 대한 것을 나타낼 Alert
                print(err.localizedDescription)
                if let err = err as? FirebaseError {
                    AlertView.show(err.rawValue)
                } else {
                    AlertView.show(err.localizedDescription)
                }
                
            }
        }
    }
    
    func signUp() {
        coordinator?.signUp()
    }
    
    func autoLogin(isChecked: Bool) {
        saveAutoLoginLocal(isChecked)
    }
}
