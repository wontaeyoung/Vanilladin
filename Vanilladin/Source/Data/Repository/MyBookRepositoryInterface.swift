protocol MyBookRepositoryInterface: DependencyContainable {
    func save(myBook: MyBook) throws
    func fetch(isbn13: String) async throws -> MyBook
    func fetch() async throws -> [MyBook]
    func isRegistered(isbn13: String) -> Bool
}
