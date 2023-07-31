enum DependencyModules {
    case httpClient
    case aladinService(HTTPClient)
    case bookRepository(AladinService)
    
    func instance() -> DependencyContainable {
        switch self {
        case .httpClient:
            return HTTPClient()
            
        case .aladinService(let httpClient):
            return AladinService(httpClient: httpClient)
            
        case .bookRepository(let aladinService):
            return BookRepository(aladinService: aladinService)
        }
    }
}
