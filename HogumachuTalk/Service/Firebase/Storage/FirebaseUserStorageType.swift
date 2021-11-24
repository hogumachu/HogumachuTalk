import RxSwift

protocol FirebaseUserStorageType {
    func setCurrentUser()
    func userObservable() -> Observable<User>
    func updateUserName(name: String)
    func updateUserStatus(status: String)
    func updateUserProfileImageURL(url: String)
    func updateUserBackgroundImageURL(url: String)
    func loadImageURL(type: ProfileImageType) -> String
}
