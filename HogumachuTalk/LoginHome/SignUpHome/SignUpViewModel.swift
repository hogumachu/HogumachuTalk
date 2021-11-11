class SignUpViewModel: ViewModelType {
    var coordinator: Coordinator?
    
    func signUp(email: String, password: String, confirmPassword: String, userName: String) {
        // TODO: - 조건 분기 처리
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty || userName.isEmpty {
            print("TextField 를 다 채워야 함 !")
            return
        }
        
        if password != confirmPassword {
            print("비밀번호가 동일해야 함 !")
            return
        }
        
        FirebaseImp.shared.signUp(email: email, password: password, userName: userName) { result in
            switch result {
            case .success(_):
                print("회원가입 성공")
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
