import UIKit

protocol HTTPClientInterface {
    func sendDTORequest<DTO: Decodable>(
        apiRequest: APIRequest,
        decodeType: DTO.Type
    ) async throws -> DTO
    
    func sendImageRequest(
        urlStr: String
    ) async throws -> UIImage?
}
