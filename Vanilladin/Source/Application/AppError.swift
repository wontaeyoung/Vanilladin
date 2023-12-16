enum AppError: AppErrorProtocol {
    case unwrapSelfFailed
    
    var errorDescription: String {
        switch self {
            case .unwrapSelfFailed:
                return "weak self 언래핑에 실패했습니다."
        }
    }
}
