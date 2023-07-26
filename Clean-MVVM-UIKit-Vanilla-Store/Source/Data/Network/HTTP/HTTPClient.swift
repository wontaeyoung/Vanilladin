import Foundation

final class HTTPClient: HTTPClientInterface {
    // MARK: - Method
    func sendRequest<DTO: Decodable>(
        apiRequest: APIRequest,
        decodeType: DTO.Type
    ) async throws -> DTO {
        let components: URLComponents = getURLComponents(with: apiRequest)
        
        guard let url = components.url else {
            print(#function, AladinAPIError.invalidURL.errorDescription)
            throw AladinAPIError.invalidURL
        }
        
        let request: URLRequest = .init(url: url)
        
        let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            print(#function, AladinAPIError.invalidResponse.errorDescription)
            throw AladinAPIError.invalidResponse
        }
        
        guard 200...299 ~= response.statusCode else {
            print(#function, AladinAPIError.unexpectedStatusCode.errorDescription)
            throw AladinAPIError.unexpectedStatusCode
        }
        
        guard let decodedDTO = try? JSONDecoder().decode(decodeType, from: data) else {
            print(#function, AladinAPIError.failToDecoding.errorDescription)
            throw AladinAPIError.failToDecoding
        }
        
        return decodedDTO
    }
}

private extension HTTPClient {
    func getURLComponents(with apiRequest: APIRequest) -> URLComponents {
        var components = URLComponents()
        components.scheme = apiRequest.scheme.rawValue
        components.host = apiRequest.host.rawValue
        components.path = apiRequest.endpoint.path
        components.queryItems = apiRequest.endpoint.queryItems
        
        return components
    }
}
