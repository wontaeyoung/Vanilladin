final class SearchBookViewModel: ViewModelProtocol {
    enum RequestType {
        case new(keyword: String)
        case more
    }

    // MARK: - Property
    private let dataSource: BookDataSource
    private weak var coordinator: BookCoordinator?
    private weak var loadingDelegate: LoadingIndicatorDelegate?
    private weak var scrollLoadingDelegate: LoadingIndicatorDelegate?
    private(set) var isLoading: Bool
    
    var hasMoreData: Bool {
        return dataSource.hasMoreData
    }
    
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
        startLoading(type: type)
        
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
        
        stopLoading(type: type)
    }
    
    func setDelegate(_ delegate: LoadingIndicatorDelegate) {
        self.loadingDelegate = delegate
    }
}

// MARK: - Private
private extension SearchBookViewModel {
    func startLoading(type: RequestType) {
        isLoading = true
        switch type {
        case .new:
            loadingDelegate?.showIndicator()
            
        case .more:
            scrollLoadingDelegate?.showIndicator()
        }
    }
    
    func stopLoading(type: RequestType) {
        isLoading = false
        switch type {
        case .new:
            loadingDelegate?.hideIndicator()
            
        case .more:
            scrollLoadingDelegate?.hideIndicator()
        }
    }
}
