import RxSwift

protocol FirebaseFriendStorageType {
    // TODO: - Friend 데이터를 User 로 받을 지, Friend 를 새로 생성할 지 결정
    func friendObservable() -> Observable<[User]>
}
