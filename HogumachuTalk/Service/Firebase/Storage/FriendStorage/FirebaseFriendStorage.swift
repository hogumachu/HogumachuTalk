import RxSwift
import RxCocoa

class FirebaseFriendStorage: FirebaseFriendStorageType {
    struct Dependency {
        let userStorage: FirebaseUserStorageType
    }
    
    init(dependency: Dependency) {
        self.userStorage = dependency.userStorage
    }
    
    let userStorage: FirebaseUserStorageType
    
    private lazy var friendSubject = BehaviorSubject<[User]>(value: mock)
    
    func friendObservable() -> Observable<[User]> {
        return friendSubject
    }
    
    lazy var setionModelObservable = Observable.combineLatest(userStorage.userObservable(), friendObservable())
        .map { user, friend -> [UserSectionModel] in
            let userSectionModel = UserSectionModel(model: 0, items: [user])
            let friendSectionModel = UserSectionModel(model: 1, items: friend)
            
            return [userSectionModel, friendSectionModel]
        }
    
    let mock: [User] = [
        .init(identity: "Test1", userName: "Test1", email: "Test1@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(identity: "Test2", userName: "Test2", email: "Test2@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(identity: "Test3", userName: "Test3", email: "Test3@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(identity: "Test4", userName: "Test4", email: "Test4@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(identity: "Test5", userName: "Test5", email: "Test5@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(identity: "Test6", userName: "Test6", email: "Test6@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(identity: "Test7", userName: "Test7", email: "Test7@Test.com", profileImageURL: "", backgroundImageURL: "")
    ]

}

