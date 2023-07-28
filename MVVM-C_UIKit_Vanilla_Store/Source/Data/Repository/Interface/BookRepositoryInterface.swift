protocol BookRepositoryInterface {
    func fetchBooks(
        keyword: String,
        page: UInt
    ) async throws -> [Book]
}
