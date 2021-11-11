class LoginViewModel: ViewModelType {
    var coordinator: Coordinator?
    
    func logIn(email: String, password: String) {
        if email.isEmpty || password.isEmpty {
            // TODO: - 텍스트필드 다 채우라는 Alert
            print("텍스트 다 채워라잉")
            return
        }
        FirebaseImp.shared.signIn(email: email,
                                  password: password) { [weak self] result in
            
            switch result {
            case .success(_):
                self?.coordinator?.signIn()
            case .failure(let err):
                // TODO: - 에러에 대한 것을 나타낼 Alert
                print(err.localizedDescription)
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
