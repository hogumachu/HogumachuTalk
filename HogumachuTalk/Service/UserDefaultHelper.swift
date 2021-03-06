import Foundation

func saveUserLocal(_ user: User) {
    do {
        let data = try JSONEncoder().encode(user)
        UserDefaults.standard.set(data, forKey: _currentUserKey)
    } catch {
        print("Local 에 저장하는데 에러 발생", #function, error.localizedDescription)
    }
}

func saveAutoLoginLocal(_ isChecked: Bool) {
    UserDefaults.standard.set(isChecked, forKey: _autoLoginKey)
}

var isCheckedAutoLogin: Bool {
    return UserDefaults.standard.bool(forKey: _autoLoginKey)
}

