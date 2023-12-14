import UIKit

struct MyBook: WritableEntityProtocol {
    enum ReadState: String {
        case interested
        case reading
        case completed
        case noState
    }
    
    enum starScore: Int {
        case noScore = 1
        case one
        case oneHalf
        case two
        case twoHalf
        case three
        case threeHalf
        case four
        case fourHalf
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
        
        dto.id = self.id
        dto.isbn13 = self.isbn13
        dto.title = self.title
        dto.author = self.author
        dto.cover = self.cover.description
        dto.score = score.rawValue
        dto.memo = self.memo
        dto.state = self.state.rawValue
        
        return dto
    }
}
