import UIKit

struct MyBook: WritableEntityProtocol {
    enum ReadState: String {
        case interested
        case reading
        case completed
        case noState
    }
    
    enum StarScore: Int {
        case noScore
        case one
        case two
        case three
        case four
        case five
    }
    
    // MARK: - Property
    let id: UUID
    let isbn13: String
    let title: String
    let author: String
    let cover: UIImage
    let coverURL: String
    var score: StarScore
    var memo: String
    var state: ReadState
    
    // MARK: - Initializer
    init(
        id: UUID,
        isbn13: String,
        title: String,
        author: String,
        cover: UIImage,
        coverURL: String,
        score: StarScore,
        memo: String,
        state: ReadState
    ) {
        self.id = id
        self.isbn13 = isbn13
        self.title = title
        self.author = author
        self.cover = cover
        self.coverURL = coverURL
        self.score = score
        self.memo = memo
        self.state = state
    }
    
    init(book: Book) {
        self.id = UUID()
        self.isbn13 = book.isbn13
        self.title = book.title
        self.author = book.author
        self.cover = book.coverImage ?? .init()
        self.coverURL = book.coverURL
        self.score = .noScore
        self.memo = ""
        self.state = .noState
    }
    
    // MARK: - Method
    static var dummy: Self {
        return .init(
            id: UUID(),
            isbn13: LogicConstant.ISBN13.favoriteBook,
            title: "제목",
            author: "작가",
            cover: .init(),
            coverURL: "",
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
        dto.cover = coverURL
        dto.score = score.rawValue
        dto.memo = memo
        dto.state = state.rawValue
        
        return dto
    }
}
