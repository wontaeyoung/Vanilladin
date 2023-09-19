enum DataSourceError: AppErrorProtocol {
    case findEntityFailed(entityName: String)
    
    var errorDescription: String {
        switch self {
        case let .findEntityFailed(entityName):
            return "\(entityName) 정보를 찾는데 실패했습니다. 다시 시도해주세요."
        }
    }
}
