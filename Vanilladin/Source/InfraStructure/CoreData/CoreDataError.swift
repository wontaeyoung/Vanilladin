enum CoreDataError: AppErrorProtocol {
    case storeConnectFailed
    case noResultWithQuery
    case entityNotFound
    
    var errorDescription: String {
        switch self {
            case .storeConnectFailed:
                return "저장소 연결에 실패했습니다."
                
            case .noResultWithQuery:
                return "조건에 해당하는 결과를 찾을 수 없습니다."
                
            case .entityNotFound:
                return "엔티티 이름을 찾을 수 없습니다."
        }
    }
}
