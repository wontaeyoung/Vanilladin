final class SearchBookViewModel: ViewModelProtocol {
    enum RequestType {
        case new(keyword: String)
        case more
    }

    // MARK: - Property
    private weak var coordinator: BookCoordinator?
    private let dataSource: BookDataSource
    private(set) var isLoading: Bool
    
    var isResultEmpty: Bool {
        return dataSource.entities.isEmpty
    }
    
    // MARK: - Initializer
    init(
        coordinator: BookCoordinator? = nil,
        dataSource: BookDataSource
    ) {
        self.coordinator = coordinator
        self.dataSource = dataSource
        
        self.isLoading = false
    }
    
    // MARK: - Method
    func requestBooks(type: RequestType) async {
        startLoading()
        do {
            switch type {
            case let .new(keyword):
                try await dataSource.searchNewBooks(keyword: keyword)
                
            case .more:
                try await dataSource.requestBooks()
            }
        } catch {
            coordinator?.handle(error: error)
        }
        stopLoading()
    }
}

// MARK: - Private
private extension SearchBookViewModel {
    func startLoading() {
        isLoading = true
    }
    
    func stopLoading() {
        isLoading = false
    }
}
