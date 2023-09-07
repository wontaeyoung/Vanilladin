import UIKit

final class AladinService: DependencyContainable {
    // MARK: - Property
    private let httpClient: HTTPClient
    
    // MARK: - Initializer
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    // MARK: - Method
    func requestBooks(keyword: String, page: UInt) async throws -> [BookDTO] {
        let apiRequest: APIRequest = .init(
            scheme: .https,
            host: .aladin,
            endpoint: AladinAPIEndpoint.itemSearch(
                keyword: keyword,
                page: page)
        )
        
        let booksDTO: [BookDTO] = try await httpClient
            .sendDTORequest(
                apiRequest: apiRequest,
                decodeType: BookResult.self)
            .item
        
        return booksDTO
    }
    
    func requestCoverImage(_ urlStr: String) async throws -> UIImage {
        guard let image = try await httpClient.sendImageRequest(urlStr: urlStr) else {
            return UIImage(systemName: UIConstant.SFSymbol.textBookClosedFill) ?? .actions
        }
        
        return image
    }
}
