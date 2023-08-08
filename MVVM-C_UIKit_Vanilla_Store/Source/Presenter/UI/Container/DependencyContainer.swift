final class DependencyContainer: DependencyContainerProtocol {
    
    // MARK: - Stored Property
    static let shared: DependencyContainer = .init()
    private var registry: [ObjectIdentifier : DependencyContainable] = [:]
    
    // MARK: - Initializer
    private init() { }
    
    // MARK: - Method
    func register<T: DependencyContainable>(
        instance: T
    ) {
        let key: ObjectIdentifier = .init(T.self)
        
        registry.updateValue(
            instance,
            forKey: key
        )
    }
    
    func resolve<T: DependencyContainable>() throws -> T {
        let key: ObjectIdentifier = .init(T.self)
        
        guard let instance: T = registry[key] as? T else {
            throw DependencyContainerError.instanceNotRegistered
        }
        
        return instance
    }
    
    
    /**
     App 내에서 사용하는 Module이 추가되면 함수 내에서 인스턴스 생성 + modules 배열에 추가가 필요합니다.
     
     DependencyModules 열거형 케이스를 전달받아서 자동으로 추가하는 방법을 구현 시도했으나, 인스턴스 초기화 의존성을 추상화하지 못해서 폐기되었습니다.
     */
    func setDependency(coordinator: CoordinatorProtocol) {
        
        let httpClient: HTTPClient = .init()
        let aladinService: AladinService = .init(httpClient: httpClient)
        let bookRepository: BookRepository = .init(aladinService: aladinService)
        let bookListViewModel: BookListViewModel = .init(coordinator: coordinator as? BookCoordinator)
        let bookListViewController: BookListViewController = .init(bookListViewModel: bookListViewModel)
        let searchBookViewModel: SearchBookViewModel = .init(coordinator: coordinator as? BookCoordinator)
        let searchBookViewController: SearchBookViewController = .init(
            searchBookViewModel: searchBookViewModel,
            bookListViewController: bookListViewController
        )
        
        let modules: [DependencyContainable] = [
            httpClient,
            aladinService,
            bookRepository,
            bookListViewModel,
            bookListViewController,
            searchBookViewModel,
            searchBookViewController
        ]
        
        modules.forEach { module in
            register(instance: module)
        }
    }
}
