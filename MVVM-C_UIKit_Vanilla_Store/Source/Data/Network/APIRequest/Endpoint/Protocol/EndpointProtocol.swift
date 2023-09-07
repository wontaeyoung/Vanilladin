import Foundation

protocol EndpointProtocol {
    var defaultPath: String { get }
    var optionalPath: String { get }
    var path: String { get }
    var defaultQueryItems: [URLQueryItem] { get }
    var optionalQueryItems: [URLQueryItem] { get }
    var queryItems: [URLQueryItem] { get }
}

extension EndpointProtocol {
    var path: String {
        return defaultPath + optionalPath
    }
    
    var queryItems: [URLQueryItem] {
        return defaultQueryItems + optionalQueryItems
    }
}
