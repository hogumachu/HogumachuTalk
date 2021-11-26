import RxSwift
import RxCocoa

class FirebaseFriendStorage: FirebaseFriendStorageType {
    private lazy var friendSubject = BehaviorSubject<[User]>(value: mock)
    
    func friendObservable() -> Observable<[User]> {
        return friendSubject
    }
    
    let mock: [User] = [
        .init(id: "Test1", userName: "Test1", email: "Test1@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test2", userName: "Test2", email: "Test2@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test3", userName: "Test3", email: "Test3@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test4", userName: "Test4", email: "Test4@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test5", userName: "Test5", email: "Test5@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test6", userName: "Test6", email: "Test6@Test.com", profileImageURL: "", backgroundImageURL: ""),
        .init(id: "Test7", userName: "Test7", email: "Test7@Test.com", profileImageURL: "", backgroundImageURL: "")
    ]

}

