protocol BookMemoRepositoryInterface: DependencyContainable {
    func save(bookMemoDTO: BookMemoDTO) throws
    func fetchBookMemo(isbn13: String) throws
    func fetchBookMemos() throws
}
