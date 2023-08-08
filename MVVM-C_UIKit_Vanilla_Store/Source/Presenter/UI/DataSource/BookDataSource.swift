final class BookDataSource: DataSourceProtocol {
    typealias Entity = Book
    
    private weak var delegate: DataSourceDelegateProtocol?
    
    var entities: [Entity] {
        didSet {
            delegate?.entitiesDidUpdate()
        }
    }
    
    init(
        entities: [Book] = []
    ) {
        self.entities = entities
    }
}
