enum DependencyContainerError: AppErrorProtocol {
    case instanceNotRegistered
    
    var errorDescription: String {
        switch self {
        case .instanceNotRegistered:
            return "등록된 인스턴스를 찾을 수 없습니다. 다시 시도해주세요."
        }
    }
}
