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
}
