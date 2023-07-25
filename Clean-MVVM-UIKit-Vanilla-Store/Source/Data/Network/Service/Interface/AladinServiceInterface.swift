protocol AladinServiceInterface {
    func requestBooks(
        query: String,
        page: Int
    ) async throws -> [BookDTO]
}
