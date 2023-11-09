final class DependencyContainer: DependencyContainerProtocol {
    // MARK: - Property
    static let shared: DependencyContainer = .init()
    private var registry: [ObjectIdentifier: DependencyContainable] = [:]
    
    // MARK: - Initializer
    private init() { }
    
    // MARK: - Method
    func register<T: DependencyContainable>(instance: T) {
        let key: ObjectIdentifier = .init(T.self)
        
        registry.updateValue(instance, forKey: key)
    }
    
    func resolve<T: DependencyContainable>() throws -> T {
        let key: ObjectIdentifier = .init(T.self)
        
        guard let instance: T = registry[key] as? T else {
            throw DependencyContainerError.instanceNotRegistered
        }
        
        return instance
    }
    
    func unregister<T: DependencyContainable>(instance: T) {
        let key: ObjectIdentifier = .init(T.self)
        
        registry.removeValue(forKey: key)
    }
    /**
     App 내에서 사용하는 Module이 추가되면 함수 내에서 인스턴스 생성 + modules 배열에 추가가 필요합니다.
     
     DependencyModules 열거형 케이스를 전달받아서 자동으로 추가하는 방법을 구현 시도했으나, 인스턴스 초기화 의존성을 추상화하지 못해서 폐기되었습니다.
     */
    func setDependency() {
        // MARK: - Netowrk
        let httpClient: HTTPClient = .init()
        let aladinService: AladinService = .init(httpClient: httpClient)
        
        // MARK: - Repository
        let bookRepository: BookRepository = .init(aladinService: aladinService)
        let searchKeywordRepository: SearchKeywordRepository = .init(userDefault: .standard)
        
        // MARK: - DataSource
        let bookDataSource: BookDataSource = .init(bookRepository: bookRepository)
        let searchHistoryDataSource: SearchHistoryDataSource = .init(searchKeywordRepository: searchKeywordRepository)
        
        // MARK: - ViewModel
        let bookListViewModel: BookListViewModel = .init(
            coordinator: coordinator as? BookCoordinator,
            bookDataSource: bookDataSource)
        let searchHistoryViewmodel: SearchHistoryViewModel = .init(dataSource: searchHistoryDataSource)
        let searchBookViewModel: SearchBookViewModel = .init(
            coordinator: coordinator as? BookCoordinator,
            dataSource: bookDataSource)
        let bookDetailViewModel: BookDetailViewModel = .init(bookRepository: bookRepository)
        
        // MARK: - ViewController
        let searchHistoryViewController: SearchHistoryViewController = .init(
            searchBookViewModel: searchBookViewModel,
            searchHistoryViewModel: searchHistoryViewmodel)
        let bookListViewController: BookListViewController = .init(
            searchBookViewModel: searchBookViewModel,
            bookListViewModel: bookListViewModel)
        let searchResultContainerViewController: SearchResultContainerViewController = .init(
            searchHistoryViewController: searchHistoryViewController,
            bookListViewController: bookListViewController)
        let searchBookViewController: SearchBookViewController = .init(
            searchBookViewModel: searchBookViewModel,
            searchHistoryViewModel: searchHistoryViewmodel,
            searchResultContainerViewController: searchResultContainerViewController)
        
        let modules: [DependencyContainable] = [
            // MARK: - Netowrk
            httpClient,
            aladinService,
            
            // MARK: - Repository
            bookRepository,
            searchKeywordRepository,
            
            // MARK: - DataSource
            bookDataSource,
            searchHistoryDataSource,
            
            // MARK: - ViewModel
            bookListViewModel,
            searchHistoryViewmodel,
            searchBookViewModel,
            bookDetailViewModel,
            
            // MARK: - ViewController
            bookListViewController,
            searchHistoryViewController,
            searchResultContainerViewController,
            searchBookViewController
        ]
        
        modules.forEach { module in
            register(instance: module)
        }
    }
}
