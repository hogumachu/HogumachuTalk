class LoginViewModel {
    func logIn(email: String, password: String) {
        if email.isEmpty || password.isEmpty {
            // TODO: - 텍스트필드 다 채우라는 Alert
            return
        }
        FirebaseImp.shared.signIn(email: email,
                                  password: password) { result in
            // TODO: - Completion
        }
    }
}
