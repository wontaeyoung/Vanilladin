import Foundation

enum AladinAPIEndpoint: EndpointProtocol {
    case itemSearch
    case itemList(query: String, page: Int)
    case itemLookUp
    
    var defaultPath: String {
        return "/ttb/api"
    }
    
    var optionalPath: String {
        switch self {
            case .itemSearch:
                return "/ItemSearch.aspx"
            case .itemList:
                return "/ItemList.aspx"
            case .itemLookUp:
                return "/ItemLookUp.aspx"
        }
    }
    
    var defaultQueryItems: [URLQueryItem] {
        switch self {
            case .itemSearch:
                return []
            case .itemList(_, _):
                return [
                    URLQueryItem(name: "ttbkey", value: ProcessInfo.processInfo.environment["TTB_KEY"]),
                    URLQueryItem(name: "QueryType", value: "ItemNewAll"),
                    URLQueryItem(name: "Cover", value: "Big"),
                    URLQueryItem(name: "Output", value: "JS"),
                    URLQueryItem(name: "Version", value: "20131101")
                ]
            case .itemLookUp:
                return []
        }
    }
    
    var optionalQueryItems: [URLQueryItem] {
        switch self {
            case .itemSearch:
                return []
            case .itemList(let query, let page):
                return [
                    URLQueryItem(name: "query", value: query),
                    URLQueryItem(name: "page", value: page.description),
                ]
            case .itemLookUp:
                return []
        }
    }
    

}
