import UIKit

final class SearchKeywordRepository: SearchKeywordRepositoryInterface {
    enum KeywordState {
        case containKeyword
        case greaterThanOrEqualMaxCount
        case lessThanMaxCount
    }
    
    // MARK: - Property
    private let userDefault: UserDefaults
    var keywords: [String] {
        guard let keywords: [String] = userDefault.stringArray(forKey: LogicConstant.UserDefault.searchKeywordKey) else {
            return []
        }
        
        return keywords
    }
    
    // MARK: - Initializer
    init(userDefault: UserDefaults) {
        self.userDefault = userDefault
    }
    
    // MARK: - Method
    func saveKeyword(_ keyword: String) {
        var keywords: [String] = keywords
        let state: KeywordState = checkKeywordState(keyword)
        
        switch state {
        case .containKeyword:
            if let index: Int = keywordIndex(keyword) {
                keywords.remove(at: index)
            }
            
        case .greaterThanOrEqualMaxCount:
            keywords.removeLast()
            
        case .lessThanMaxCount:
            break
        }
        
        insertKeywordAtFirst(keyword, for: &keywords)
        setKeywords(keywords)
    }
    
    func removeKeyword(at index: Int) {
        var keywords: [String] = keywords
        keywords.safeRemove(at: index)
        setKeywords(keywords)
    }
    
    func clearKeywords() {
        removeAllKeywords()
    }
}

private extension SearchKeywordRepository {
    func removeAllKeywords() {
        userDefault.removeObject(forKey: LogicConstant.UserDefault.searchKeywordKey)
    }
    
    func keywordIndex(_ keyword: String) -> Int? {
        let lowerKeywords: [String] = keywords.map { $0.lowercased() }
        let lowerKeyword: String = keyword.lowercased()
        
        return lowerKeywords.firstIndex(of: lowerKeyword)
    }
    
    func insertKeywordAtFirst(
        _ keyword: String,
        for keywords: inout [String]
    ) {
        keywords.insert(keyword, at: 0)
    }
    
    func setKeywords(_ keywords: [String]) {
        userDefault.set(keywords, forKey: LogicConstant.UserDefault.searchKeywordKey)
    }
    
    func checkKeywordState(_ keyword: String) -> KeywordState {
        let isDuplicated: Bool = keywords
            .map({ $0.lowercased() })
            .contains(keyword.lowercased())
        
        let isFull: Bool = keywords.count >= LogicConstant.UserDefault.maxKeywordCount
        
        if isDuplicated {
            return .containKeyword
        }
        
        if isFull {
            return .greaterThanOrEqualMaxCount
        }
        
        return .lessThanMaxCount
    }
}
