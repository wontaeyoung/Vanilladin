protocol BookRepositoryInterface {
    func fetchBooks(
        query: String,
        page: Int
    ) async throws -> [Book]
}
