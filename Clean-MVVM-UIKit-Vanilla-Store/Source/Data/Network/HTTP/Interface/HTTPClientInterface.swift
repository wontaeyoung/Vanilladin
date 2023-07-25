protocol HTTPClientInterface {
    func sendRequest<DTO: Decodable>(
        apiRequest: APIRequest,
        decodeType: DTO.Type
    ) async throws -> DTO
}
