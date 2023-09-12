final class SearchBookViewModel: ViewModelProtocol {
    // MARK: - Property
    private weak var coordinator: BookCoordinator?
    private let bookRepository: BookRepository
    private let dataSource: BookDataSource
    private var searchKeyword: String
    private(set) var isLoading: Bool
    private(set) var hasMoreData: Bool
    
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
        self.hasMoreData = true
    }
    
    // MARK: - Method
    func searchNewBooks(keyword: String) async {
        self.searchKeyword = keyword
        dataSource.clearEntities()
        dataSource.resetLoadPage()
        await fetchBooks()
    }
    
    func fetchBooks() async {
        startLoading()
        
        do {
            let books: (totalItem: UInt, data: [Book]) = try await bookRepository.fetchBooks(
                keyword: searchKeyword,
                page: dataSource.currentLoadPage)
            
            dataSource.entities.append(contentsOf: books.data)
            
            hasMoreData = checkMoreData(totalItem: books.totalItem)
        } catch {
            guard let error = error as? AppErrorProtocol else {
                print(#function, "에러 타입캐스팅 실패!")
                return
            }
            
            coordinator?.handle(error: error)
        }
        
        stopLoading()
    }
    
    // MARK: Interface
    func increaseLoadPage() {
        dataSource.increaseLoadPage()
    }
    
    // MARK: Private
    private func startLoading() {
        isLoading = true
    }
    
    private func stopLoading() {
        isLoading = false
    }
    
    private func checkMoreData(totalItem: UInt) -> Bool {
        guard let itemsPerPage = UInt(AladinAPIConstant.ItemSearch.maxResults) else {
            return false
        }
        
        return totalItem > dataSource.currentLoadPage * itemsPerPage
    }
}
