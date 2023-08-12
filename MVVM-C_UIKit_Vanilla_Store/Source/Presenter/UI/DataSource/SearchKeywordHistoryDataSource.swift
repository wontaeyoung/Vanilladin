import UIKit

final class SearchKeywordHistoryDataSource: NSObject {
    enum KeywordState {
        case containKeyword
        case greaterThanOrEqualMaxCount
        case lessThanMaxCount
    }
    
    // MARK: - Stored Property
    let userDefault: UserDefaults
    
    // MARK: - Computed Property
    private var keywords: [String] {
        guard let keywords: [String] = userDefault.stringArray(
            forKey: LogicConstant.UserDefault.searchKeywordKey
        ) else {
            return []
        }
        
        return keywords
    }
    
    // MARK: - Initializer
    override init() {
        self.userDefault = .standard
    }
    
    // MARK: - Method
    private func setKeywords(_ keywords: [String]) {
        userDefault.set(keywords, forKey: LogicConstant.UserDefault.searchKeywordKey)
    }
    
    private func keywordIndex(_ keyword: String) -> Int? {
        return keywords.firstIndex(of: keyword)
    }
    
    private func checkKeywordState(_ keyword: String) -> KeywordState {
        if keywords.contains(keyword) {
            return .containKeyword
        }
        
        if keywords.count >= LogicConstant.UserDefault.maxKeywordCount {
            return .greaterThanOrEqualMaxCount
        }
        
        return .lessThanMaxCount
    }
    
    private func insertKeywordAtFirst(_ keyword: String, for keywords: inout [String]) {
        keywords.insert(keyword, at: 0)
    }
    
    func saveKeyword(keyword: String) {
        var keywords: [String] = self.keywords
        
        switch checkKeywordState(keyword) {
            case .containKeyword:
                if let index: Int = keywordIndex(keyword) { keywords.remove(at: index) }
            case .greaterThanOrEqualMaxCount: keywords.removeLast()
            case .lessThanMaxCount: break
        }
        
        insertKeywordAtFirst(keyword, for: &keywords)
        
        setKeywords(keywords)
    }
}

extension SearchKeywordHistoryDataSource: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return keywords.count
    }
}
