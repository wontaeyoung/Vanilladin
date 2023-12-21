final class BookDetailViewModel: ViewModelProtocol {
    // MARK: - Property
    private let dataSource: MyBookDataSource
    
    // MARK: - Initializer
    init(dataSource: MyBookDataSource) {
        self.dataSource = dataSource
    }
    
    // MARK: - Method
    func isRegister(isbn13: String) -> Bool {
        return dataSource.isRegistered(isbn13: isbn13)
    }
}
