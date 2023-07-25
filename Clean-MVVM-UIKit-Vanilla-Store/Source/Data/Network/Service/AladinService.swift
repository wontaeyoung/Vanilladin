final class AladinService: AladinServiceInterface {
    // MARK: - Stored Property
    private let httpClient: HTTPClientInterface
    
    // MARK: - Initializer
    init(
        httpClient: HTTPClientInterface = HTTPClient()
    ) {
        self.httpClient = httpClient
    }
    
    // MARK: - Method
    func requestBooks(
        query: String,
        page: Int
    ) async throws -> [BookDTO] {
        let apiRequest: APIRequest = .init(
            scheme: .http,
            host: .aladin,
            endpoint: AladinAPIEndpoint.itemList(
                query: query,
                page: page
            )
        )
        
        let booksDTO: [BookDTO] = try await httpClient
            .sendRequest(
                apiRequest: apiRequest,
                decodeType: Result.self
            )
            .item
        
        return booksDTO
    }
}
