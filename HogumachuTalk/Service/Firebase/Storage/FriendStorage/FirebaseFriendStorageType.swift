import RxSwift
import RxDataSources

protocol FirebaseFriendStorageType {
    // TODO: - Friend 데이터를 User 로 받을 지, Friend 를 새로 생성할 지 결정
    var userStorage: FirebaseUserStorageType { get }
    func friendObservable() -> Observable<[User]>
    var setionModelObservable: Observable<[UserSectionModel]> { get set }
    
}
