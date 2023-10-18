protocol SearchKeywordRepositoryInterface: DependencyContainable {
    var keywords: [String] { get }
    
    func saveKeyword(_ keyword: String)
    func removeKeyword(at index: Int)
    func clearKeywords()
}
