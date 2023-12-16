protocol MyBookRepositoryInterface: DependencyContainable {
    func save(myBook: MyBook) throws
    func fetch(isbn13: String) async throws -> MyBook
    func fetch() async throws -> [MyBook]
}
