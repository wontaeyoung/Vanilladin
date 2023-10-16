protocol BookRepositoryInterface: DependencyContainable {
    func fetchBooks(
        keyword: String,
        page: UInt
    ) async throws -> (totalItem: UInt, data: [Book])
    
    func fetchBookDetail(isbn13: String) async throws -> BookDetail
}
