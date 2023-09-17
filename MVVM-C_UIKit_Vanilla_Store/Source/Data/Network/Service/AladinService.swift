import UIKit

final class AladinService: DependencyContainable {
    // MARK: - Property
    private let httpClient: HTTPClient
    
    // MARK: - Initializer
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    // MARK: - Method
    /**
     검색어로 API 요청을 수행해서 검색 결과에 해당하는 데이터를 반환합니다.
     
     - parameters:
     - parameterkeyword: 검색어 query에 해당하는 문자열입니다.
     - parameterpage: 검색어에 해당하는 결과 중 가져올 페이지 번호입니다. maxResults 파라미터에 따라 포함되는 결과가 변경됩니다.
     
     - Returns: 전체 결과 갯수, 책 정보 리스트를 포함한 구조체를 반환합니다.
     */
    func requestBooks(keyword: String, page: UInt) async throws -> SearchBookResult {
        let apiRequest: APIRequest = .init(
            scheme: .https,
            host: .aladin,
            endpoint: AladinAPIEndpoint.itemSearch(
                keyword: keyword,
                page: page)
        )
        
        let bookResult: SearchBookResult = try await httpClient
            .sendDTORequest(
                apiRequest: apiRequest,
                decodeType: SearchBookResult.self)
        
        return bookResult
    }
    
    func requestCoverImage(_ urlStr: String) async throws -> UIImage {
        guard let image = try await httpClient.sendImageRequest(urlStr: urlStr) else {
            return UIImage(systemName: UIConstant.SFSymbol.textBookClosedFill) ?? .actions
        }
        
        return image
    }
    
    func requestBookDetail(isbn13: String) async throws -> LookupBookResult {
        let apiRequest: APIRequest = .init(
            scheme: .https,
            host: .aladin,
            endpoint: AladinAPIEndpoint.itemLookUp(isbn13: isbn13)
        )
        
        let bookResult: LookupBookResult = try await httpClient.sendDTORequest(
            apiRequest: apiRequest,
            decodeType: LookupBookResult.self)
        
        return bookResult
    }
}
