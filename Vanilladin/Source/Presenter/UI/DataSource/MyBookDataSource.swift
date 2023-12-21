final class MyBookDataSource: DataSourceProtocol {
    typealias Entity = MyBook
    
    // MARK: - Property
    private let myBookRepository: MyBookRepositoryInterface
    private weak var delegate: DataSourceDelegate?
    
    var entities: [Entity] {
        didSet {
            delegate?.entitiesDidUpdate()
        }
    }
    
    // MARK: - Intializer
    init(
        myBookRepository: MyBookRepositoryInterface,
        delegate: DataSourceDelegate? = nil,
        entities: [Entity] = []
    ) {
        self.myBookRepository = myBookRepository
        self.delegate = delegate
        self.entities = entities
    }
    
    // MARK: - Method
    func fetchMyBooks() async throws {
        let entities: [Entity] = try await myBookRepository.fetch()
        
        updateEntities(with: entities)
    }
    
    func isRegistered(isbn13: String) -> Bool {
        return myBookRepository.isRegistered(isbn13: isbn13)
    }
}

private extension MyBookDataSource {
    func updateEntities(with myBooks: [MyBook]) {
        entities = myBooks
    }
}
