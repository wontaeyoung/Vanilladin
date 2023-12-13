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
    var memo: String
    var state: ReadState
    
    static var dummy: Self {
        .init(
            id: UUID(),
            isbn13: LogicConstant.ISBN13.favoriteBook,
            memo: "",
            state: .noState)
    }
    
    func asDTO() -> BookMemoDTO {
        let dto: BookMemoDTO = .init()
        
        dto.id = self.id
        dto.isbn13 = self.isbn13
        dto.memo = self.memo
        dto.state = self.state.rawValue
        
        return dto
    }
}
