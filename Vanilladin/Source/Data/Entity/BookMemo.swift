import Foundation

struct BookMemo: WritableEntityProtocol {
    enum ReadState: String {
        case interested
        case reading
        case completed
        case noState
    }
    
    let id: UUID
    let isbn13: String
    let memo: String
    var state: ReadState
    
    static var dummy: Self {
        .init(
            id: UUID(),
            isbn13: LogicConstant.ISBN13.favoriteBook,
            memo: "",
            state: .noState)
    }
    
    func asDTO() -> BookMemoDTO {
        .init(
            id: id.uuidString,
            isbn13: isbn13,
            memo: memo,
            state: state.rawValue)
    }
}
