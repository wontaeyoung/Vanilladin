final class SearchBookViewModel: ViewModelProtocol {
    enum RequestType {
        case new(keyword: String)
        case more
    }
    
    enum SetDelegateType {
        case searchLoadingIndicator
        case scrollLoadingIndicator
    }

    // MARK: - Property
    private let dataSource: BookDataSource
    private weak var coordinator: BookCoordinator?
    private weak var searchLoadingDelegate: LoadingIndicatorDelegate?
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
    
    func setDelegate(_ delegate: LoadingIndicatorDelegate, type: SetDelegateType) {
        switch type {
        case .searchLoadingIndicator:
            self.searchLoadingDelegate = delegate
            
        case .scrollLoadingIndicator:
            self.scrollLoadingDelegate = delegate
        }
    }
}

// MARK: - Private
private extension SearchBookViewModel {
    func startLoading(type: RequestType) {
        isLoading = true
        switch type {
        case .new:
            searchLoadingDelegate?.showIndicator()
            
        case .more:
            scrollLoadingDelegate?.showIndicator()
        }
    }
    
    func stopLoading(type: RequestType) {
        isLoading = false
        switch type {
        case .new:
            searchLoadingDelegate?.hideIndicator()
            
        case .more:
            scrollLoadingDelegate?.hideIndicator()
        }
    }
}
