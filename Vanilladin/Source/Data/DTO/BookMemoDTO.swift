import UIKit
import CoreData

@objc(BookMemo)
final class BookMemoDTO: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var isbn13: String
    @NSManaged var memo: String
    @NSManaged var state: String
    
    func asModel() -> BookMemo {
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
