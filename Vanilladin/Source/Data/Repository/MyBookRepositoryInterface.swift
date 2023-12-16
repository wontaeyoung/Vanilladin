protocol MyBookRepositoryInterface: DependencyContainable {
    func fetch(isbn13: String) throws -> MyBookDTO
    func fetch() throws -> [MyBookDTO]
    func save(myBook: MyBook) throws
}
