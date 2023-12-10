import UIKit

final class BookMemoDTO: DTOProtocol {
    let id: UUID
    let isbn13: String
    let memo: String
    var state: String
    
    init(
        id: UUID,
        isbn13: String,
        memo: String,
        state: String
    ) {
        self.id = id
        self.isbn13 = isbn13
        self.memo = memo
        self.state = state
    }
    
    func asModel(with coverImage: UIImage?) -> BookMemo {
        guard let state = BookMemo.ReadState(rawValue: state) else {
            return .dummy
        }
        
        return .init(
            id: id,
            isbn13: isbn13,
            memo: memo,
            state: state)
    }
}
