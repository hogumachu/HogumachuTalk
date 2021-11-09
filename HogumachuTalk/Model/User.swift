struct User: Codable, Equatable {
    let id: String
    var userName: String
    var email: String
    var profileImageURL: String
    var status: String = "안녕하세요. 반갑습니다"
}

extension User {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
