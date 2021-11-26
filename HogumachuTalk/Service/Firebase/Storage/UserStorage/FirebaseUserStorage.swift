import RxSwift

class FirebaseUserStorage: FirebaseUserStorageType {
    private var user: User = .currentUser ?? .empty
    private lazy var userSubject = BehaviorSubject<User>(value: user)
    
    func setCurrentUser() {
        FirebaseImp.shared.downloadCurrentUser { [weak self] user in
            if let user = user {
                self?.user = user
                self?.userSubject.onNext(user)
            }
        }
    }
    
    func userObservable() -> Observable<User> {
        return userSubject
    }
    
    func updateUserName(name: String) {
        if name.isEmpty || user.userName == name {
            return
        }
        user.userName = name
        userSubject.onNext(user)
        FirebaseImp.shared.uploadUser(user)
    }
    
    func updateUserStatus(status: String) {
        if user.status == status {
            return
        }
        user.status = status
        userSubject.onNext(user)
        FirebaseImp.shared.uploadUser(user)
    }
    
    func updateUserProfileImageURL(url: String) {
        if user.profileImageURL == url {
            return
        }
        user.profileImageURL = url
        userSubject.onNext(user)
        FirebaseImp.shared.uploadUser(user)
    }
    
    func updateUserBackgroundImageURL(url: String) {
        if user.backgroundImageURL == url {
            return
        }
        user.backgroundImageURL = url
        userSubject.onNext(user)
        FirebaseImp.shared.uploadUser(user)
    }
    
    func loadImageURL(type: ProfileImageType) -> String {
        return type == .profile ? user.profileImageURL : user.backgroundImageURL
    }
}
