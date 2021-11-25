import UIKit

class SignUpViewModel: ViewModelType {
    struct Dependency {
        let coordinator: Coordinator
    }
    
    // MARK: - Properties
    
    var coordinator: Coordinator
    
    // MARK: - Initialize
    
    init(dependency: Dependency) {
        self.coordinator = dependency.coordinator
    }
    
    // MARK: - Helper
    
    func signUp(_ viewController: UIViewController, email: String, password: String, confirmPassword: String, userName: String) {
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty || userName.isEmpty {
            AlertView.show("텍스트를 모두 채워야 합니다")
            return
        }
        
        if password != confirmPassword {
            AlertView.show("비밀번호가 동일하지 않습니다")
            return
        }
        
        FirebaseImp.shared.signUp(email: email, password: password, userName: userName) { [weak self] result in
            switch result {
            case .success(_):
                AlertView.show(
                               """
                               회원가입 성공
                               메일을 인증해주세요.
                               """
                )
                self?.coordinator.dismiss(viewController, animated: true)
            case .failure(let err):
                AlertView.show(err.localizedDescription)
            }
        }
    }
}
