protocol MyBookRepositoryInterface: DependencyContainable {
    func fetch() throws -> [MyBookDTO]
    func save(myBook: MyBook) throws
    func fetch(isbn13: String) async throws -> MyBook
}
