final class BookDataSource: DataSourceProtocol {
    typealias Entity = Book
    
    var entities: [Entity]
    
    init(
        entities: [Book] = []
    ) {
        self.entities = entities
    }
}
