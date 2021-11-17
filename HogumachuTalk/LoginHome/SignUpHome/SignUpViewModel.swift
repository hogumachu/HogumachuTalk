import UIKit

class SignUpViewModel: ViewModelType {
    var coordinator: Coordinator?
    
    func signUp(_ viewController: UIViewController, email: String, password: String, confirmPassword: String, userName: String) {
        // TODO: - 조건 분기 처리
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty || userName.isEmpty {
            print("TextField 를 다 채워야 함 !")
            
            AlertView.show("텍스트를 모두 채워야 합니다")
            return
        }
        
        if password != confirmPassword {
            print("비밀번호가 동일해야 함 !")
            
            AlertView.show("비밀번호가 동일하지 않습니다")
            return
        }
        
        FirebaseImp.shared.signUp(email: email, password: password, userName: userName) { [weak self] result in
            switch result {
            case .success(_):
                print("회원가입 성공")
                AlertView.show(
                               """
                               회원가입 성공
                               메일을 인증해주세요.
                               """
                )
                self?.coordinator?.dismiss(viewController, animated: true)
            case .failure(let err):
                print(err.localizedDescription)
                AlertView.show(err.localizedDescription)
            }
        }
    }
}
