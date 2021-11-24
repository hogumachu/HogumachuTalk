import RxSwift

protocol FirebaseUserStorageType {
    func setUser(user: User)
    func userObservable() -> Observable<User>
    func updateUser(name: String, status: String, profileImageURL: String, backgroundImageURL: String)
    func loadImageURL(type: ProfileImageType) -> String
}
