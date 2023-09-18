enum DataSourceError: AppErrorProtocol {
    case loadBookFailed
    
    var errorDescription: String {
        switch self {
        case .loadBookFailed:
            return "책 정보를 불러오는데 실패했습니다."
        }
    }
}
