enum AladinAPIError: AppErrorProtocol {
    case invalidURL
    case invalidResponse
    case failToDecoding
    case failToEncoding
    case failToLoadREADME
    case unauthorized
    case unexpectedStatusCode
    case notModified
    case requiresAuthentification
    case forbidden
    case notFound
    case failToRequest
    case unknown
    
    var errorDescription: String {
        switch self {
            case .invalidURL:
                return "잘못된 URL입니다."
            case .invalidResponse:
                return "올바르지 않은 응답입니다."
            case .failToDecoding:
                return "데이터 디코딩에 실패하였습니다."
            case .failToEncoding:
                return "데이터 인코딩에 실패하였습니다."
            case .failToLoadREADME:
                return "README 파일 로딩에 실패하였습니다."
            case .unauthorized:
                return "인증되지 않았습니다."
            case .unexpectedStatusCode:
                return "예상치 못한 상태 코드입니다."
            case .notModified:
                return "수정되지 않았습니다."
            case .requiresAuthentification:
                return "인증이 필요합니다."
            case .forbidden:
                return "접근이 금지되었습니다."
            case .notFound:
                return "찾을 수 없습니다."
            case .failToRequest:
                return "요청에 실패하였습니다."
            case .unknown:
                return "알 수 없는 오류가 발생하였습니다."
        }
    }
}
