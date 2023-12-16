import UIKit

struct MyBook: WritableEntityProtocol {
    enum ReadState: String {
        case interested
        case reading
        case completed
        case noState
    }
    
    enum starScore: Int {
        case noScore
        case one
        case two
        case three
        case four
        case five
    }
    
    let id: UUID
    let isbn13: String
    let title: String
    let author: String
    let cover: UIImage
    var score: starScore
    var memo: String
    var state: ReadState
    
    static var dummy: Self {
        return .init(
            id: UUID(),
            isbn13: LogicConstant.ISBN13.favoriteBook,
            title: "제목",
            author: "작가",
            cover: .init(),
            score: .noScore,
            memo: "메모",
            state: .noState)
    }
    
    func asDTO() -> MyBookDTO {
        let dto: MyBookDTO = .init()
        
        dto.id = id
        dto.isbn13 = isbn13
        dto.title = title
        dto.author = author
        dto.cover = cover.description
        dto.score = score.rawValue
        dto.memo = memo
        dto.state = state.rawValue
        
        return dto
    }
}
