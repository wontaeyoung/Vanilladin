import UIKit

final class HTTPClient: DependencyContainable {
    // MARK: - Method
    /// http 방식의 API로 데이터를 요청해서 응답을 전달받은 디코딩 타입으로 변환해서 반환하는 함수
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
    
    /// 이미지 URL로 응답받은 이미지 데이터를 UIImage로 변환해서 반환하는 함수
    func sendImageRequest(urlStr: String) async throws -> UIImage? {
        guard let url = URL(string: urlStr) else {
            print(#function, AladinAPIError.invalidURL.errorDescription)
            throw AladinAPIError.invalidURL
        }
        
        let data: Data = try await sendRequestWithURL(url: url)
        
        return UIImage(data: data)
    }
}

private extension HTTPClient {
    /// input으로 들어온 apiRequest의 속성들을 통해서 scheme, host, query parameter가 설정된 URL Component를 만들어서 반환하는 함수
    func getURLComponents(with apiRequest: APIRequest) -> URLComponents {
        var components: URLComponents = .init()
        components.scheme = apiRequest.scheme.rawValue
        components.host = apiRequest.host.rawValue
        components.path = apiRequest.endpoint.path
        components.queryItems = apiRequest.endpoint.queryItems
        
        return components
    }
    
    /// URL Component로 완성된 URL을 통해 데이터를 요청해서 반환하는 함수
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
