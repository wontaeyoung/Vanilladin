protocol MyBookRepositoryInterface: DependencyContainable {
    func save(myBookDTO: MyBookDTO) throws
    func fetch(isbn13: String) throws -> MyBookDTO
    func fetch() throws -> [MyBookDTO]
}
