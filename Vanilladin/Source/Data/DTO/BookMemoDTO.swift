final class BookMemoDTO {
    let id: String
    let isbn13: String
    let memo: String
    var state: String
    
    init(
        id: String,
        isbn13: String,
        memo: String,
        state: String
    ) {
        self.id = id
        self.isbn13 = isbn13
        self.memo = memo
        self.state = state
    }
}
