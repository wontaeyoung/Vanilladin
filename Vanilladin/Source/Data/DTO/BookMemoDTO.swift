import UIKit

final class BookMemoDTO: DTOProtocol {
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
    
    func asModel(with coverImage: UIImage?) -> BookMemo {
        guard 
            let uuid = UUID(uuidString: id),
            let state = BookMemo.ReadState(rawValue: state)
        else {
            return .dummy
        }
        
        return .init(
            id: uuid, 
            isbn13: isbn13,
            memo: memo,
            state: state)
    }
}
