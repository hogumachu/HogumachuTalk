import RxSwift

class FirebaseUserStorage: FirebaseUserStorageType {
    private var user: User = .currentUser ?? .empty
    private lazy var userSubject = BehaviorSubject<User>(value: user)
    
    func setUser(user: User) {
        self.user = user
        userSubject.onNext(user)
    }
    
    func userObservable() -> Observable<User> {
        return userSubject
    }
    
    func updateUser(name: String = "", status: String = "", profileImageURL: String = "", backgroundImageURL: String = "") {
        if !name.isEmpty {
            user.userName = name
        }
        
        if !status.isEmpty {
            user.status = status
        }
        
        if !profileImageURL.isEmpty {
            user.profileImageURL = profileImageURL
        }
        
        if !backgroundImageURL.isEmpty {
            user.backgroundImageURL = backgroundImageURL
        }
        
        FirebaseImp.shared.uploadUser(user)
        
        userSubject.onNext(user)
    }
    
    func loadImageURL(type: ProfileImageType) -> String {
        return type == .profile ? user.profileImageURL : user.backgroundImageURL
    }
}
