import UIKit

final class SearchHistoryDataSource: NSObject, DependencyContainable {
    
    // MARK: - Property
    private let searchKeywordRepository: SearchKeywordRepositoryInterface
    private weak var delegate: DataSourceDelegate?
    private var keywords: [String] {
        searchKeywordRepository.keywords
    }
    
    init(searchKeywordRepository: SearchKeywordRepository, delegate: DataSourceDelegate? = nil) {
        self.searchKeywordRepository = searchKeywordRepository
        self.delegate = delegate
    }
    
    // MARK: - Method
    func getKeyword(at index: Int) -> String? {
        return keywords.element(at: index)
    }
    
    func saveKeyword(_ keyword: String) {
        searchKeywordRepository.saveKeyword(keyword)
        delegate?.entitiesDidUpdate()
    }
    
    func removeKeyword(at index: Int) {
        searchKeywordRepository.removeKeyword(at: index)
        delegate?.entitiesDidUpdate()
    }
    
    func clearKeywords() {
        searchKeywordRepository.clearKeywords()
        delegate?.entitiesDidUpdate()
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
        guard let keywordCell: SearchKeywordCell = tableView.dequeueCell(
                SearchKeywordCell.self,
                for: indexPath) as? SearchKeywordCell
        else {
            return tableView.dequeueCell(UITableViewCell.self, for: indexPath)
        }
        
        guard let keyword: String = keywords.element(at: indexPath.row) else {
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
