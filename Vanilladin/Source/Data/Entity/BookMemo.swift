import Foundation

struct BookMemo {
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
}
