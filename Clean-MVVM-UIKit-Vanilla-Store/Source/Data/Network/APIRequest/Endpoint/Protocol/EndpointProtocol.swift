import Foundation

protocol EndpointProtocol {
    var defaultPath: String { get }
    var optionalPath: String { get }
    var path: String { get }
    var defaultQueryItems: [URLQueryItem] { get }
    var optionalQueryItems: [URLQueryItem] { get }
    var queryItems: [URLQueryItem] { get }
}
