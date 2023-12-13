protocol BookMemoRepositoryInterface: DependencyContainable {
    func save(bookMemoDTO: BookMemoDTO) throws
    func fetch(isbn13: String) throws -> BookMemoDTO
    func fetch() throws -> [BookMemoDTO]
}
