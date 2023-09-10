final class SearchBookViewModel: ViewModelProtocol {
    // MARK: - Property
    private weak var coordinator: BookCoordinator?
    private let bookRepository: BookRepository
    private let dataSource: BookDataSource
    private var searchKeyword: String
    private(set) var isLoading: Bool
    
    var isResultEmpty: Bool {
        return dataSource.entities.isEmpty
    }
    
    // MARK: - Initializer
    init(
        coordinator: BookCoordinator? = nil,
        bookRepository: BookRepository,
        dataSource: BookDataSource
    ) {
        self.coordinator = coordinator
        self.bookRepository = bookRepository
        self.dataSource = dataSource
        
        self.searchKeyword = ""
        self.isLoading = false
    }
    
    // MARK: - Method
    func fetchBooks() async {
        startLoading()
        
        do {
            let books: [Book] = try await bookRepository.fetchBooks(
                keyword: searchKeyword,
                page: dataSource.currentLoadPage)
            
            dataSource.entities.append(contentsOf: books)
        } catch {
            guard let error = error as? AppErrorProtocol else {
                print(#function, "에러 타입캐스팅 실패!")
                return
            }
            
            coordinator?.handle(error: error)
        }
        
        stopLoading()
    }
    
    func saveSearchKeyword(keyword: String) {
        self.searchKeyword = keyword
    }
    
    func increaseLoadPage() {
        dataSource.increaseLoadPage()
    }
    
    func startLoading() {
        isLoading = true
    }
    
    func stopLoading() {
        isLoading = false
    }
}
