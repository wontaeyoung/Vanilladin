import UIKit

final class SearchHistoryDataSource: NSObject, DependencyContainable {
    enum KeywordState {
        case containKeyword
        case greaterThanOrEqualMaxCount
        case lessThanMaxCount
    }
    
    // MARK: - Property
    let userDefault: UserDefaults
    private weak var delegate: DataSourceDelegate?
    
    private var keywords: [String] {
        guard
            let keywords: [String] = userDefault.stringArray(forKey: LogicConstant.UserDefault.searchKeywordKey)
        else {
            return []
        }
        
        return keywords
    }
    
    // MARK: - Initializer
    override init() {
        self.userDefault = .standard
    }
    
    // MARK: - Method
    func getKeyword(at index: Int) -> String? {
        return keywords.element(at: index)
    }
    
    func saveKeyword(keyword: String) {
        var keywords: [String] = self.keywords
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
        delegate?.entitiesDidUpdate()
    }
    
    func removeKeyword(at index: Int) {
        var keywords: [String] = self.keywords
        keywords.safeRemove(at: index)
        setKeywords(keywords)
    }
    
    func clearKeywords() {
        removeAllKeywords()
    }
}

// MARK: - Private
private extension SearchHistoryDataSource {
    func setKeywords(_ keywords: [String]) {
        userDefault.set(keywords, forKey: LogicConstant.UserDefault.searchKeywordKey)
    }
    
    func keywordIndex(_ keyword: String) -> Int? {
        return keywords.map({$0.lowercased()}).firstIndex(of: keyword.lowercased())
    }
    
    func checkKeywordState(_ keyword: String) -> KeywordState {
        if keywords.map({$0.lowercased()}).contains(keyword.lowercased()) {
            return .containKeyword
        }
        
        if keywords.count >= LogicConstant.UserDefault.maxKeywordCount {
            return .greaterThanOrEqualMaxCount
        }
        
        return .lessThanMaxCount
    }
    
    func insertKeywordAtFirst(
        _ keyword: String,
        for keywords: inout [String]
    ) {
        keywords.insert(keyword, at: 0)
    }
    
    func removeAllKeywords() {
        userDefault.removeObject(forKey: LogicConstant.UserDefault.searchKeywordKey)
    }
}

// MARK: - Set Dependency
extension SearchHistoryDataSource {
    func setDelegate(_ delegate: DataSourceDelegate) {
        self.delegate = delegate
    }
    
    func setTableViewDataSourceAsSelf(to tableView: BaseTableView) {
        tableView.dataSource = self
    }
}

// MARK: - Table DataSource
extension SearchHistoryDataSource: UITableViewDataSource {
    // Cell 갯수 설정
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return keywords.count
    }
    
    // Cell 생성 및 재사용
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let keywordCell: SearchKeywordCell = tableView.dequeueCell(
                SearchKeywordCell.self,
                for: indexPath) as? SearchKeywordCell
        else {
            return tableView.dequeueCell(UITableViewCell.self, for: indexPath)
        }
        
        guard
            let keyword: String = keywords.element(at: indexPath.row)
        else {
            return keywordCell
        }
        
        keywordCell.keyword = keyword
        keywordCell.deleteAction = { [weak self] in
            guard let self else { return }
            removeKeyword(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return keywordCell
    }
    
    // Header 문자 설정
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return "최근 검색"
    }
}
