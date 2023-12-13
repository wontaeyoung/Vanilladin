protocol BookMemoRepositoryInterface: DependencyContainable {
    func save(bookMemoDTO: MyBookDTO) throws
    func fetch(isbn13: String) throws -> MyBookDTO
    func fetch() throws -> [MyBookDTO]
}
