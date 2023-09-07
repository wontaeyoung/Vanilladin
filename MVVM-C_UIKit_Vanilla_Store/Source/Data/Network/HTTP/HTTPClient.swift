import UIKit

final class HTTPClient: DependencyContainable {
    // MARK: - Method
    func sendDTORequest<DTO: Decodable>(
        apiRequest: APIRequest,
        decodeType: DTO.Type
    ) async throws -> DTO {
        let components: URLComponents = getURLComponents(with: apiRequest)
        
        guard let url = components.url else {
            print(#function, AladinAPIError.invalidURL.errorDescription)
            throw AladinAPIError.invalidURL
        }
        
        let data: Data = try await sendRequestWithURL(url: url)
        
        guard let decodedDTO = try? JSONDecoder().decode(decodeType, from: data) else {
            print(#function, AladinAPIError.failToDecoding.errorDescription)
            throw AladinAPIError.failToDecoding
        }
        
        return decodedDTO
    }
    
    func sendImageRequest(
        urlStr: String
    ) async throws -> UIImage? {
        guard let url = URL(string: urlStr) else {
            print(#function, AladinAPIError.invalidURL.errorDescription)
            throw AladinAPIError.invalidURL
        }
        
        let data: Data = try await sendRequestWithURL(url: url)
        
        return UIImage(data: data)
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
    
    func sendRequestWithURL(url: URL) async throws -> Data {
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
        
        return data
    }
}
