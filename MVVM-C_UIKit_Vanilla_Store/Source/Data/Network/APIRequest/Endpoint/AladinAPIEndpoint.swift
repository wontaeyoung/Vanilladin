import Foundation

enum AladinAPIEndpoint: EndpointProtocol {
    case itemSearch(keyword: String, page: UInt)
    case itemList
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
                return [
                    URLQueryItem(name: AladinAPIParameter.ttbKey.name, value: AladinAPIConstant.ttbKey),
                    URLQueryItem(name: AladinAPIParameter.QueryType.name, value: AladinAPIConstant.queryType),
                    URLQueryItem(name: AladinAPIParameter.Cover.name, value: AladinAPIConstant.cover),
                    URLQueryItem(name: AladinAPIParameter.Output.name, value: AladinAPIConstant.output),
                    URLQueryItem(name: AladinAPIParameter.Version.name, value: AladinAPIConstant.version),
                ]
            case .itemList:
                return []
            case .itemLookUp:
                return []
        }
    }
    
    var optionalQueryItems: [URLQueryItem] {
        switch self {
            case .itemSearch(let keyword, let page):
                return [
                    URLQueryItem(name: AladinAPIParameter.Query.name, value: keyword),
                    URLQueryItem(name: AladinAPIParameter.Start.name, value: page.description),
                ]
            case .itemList:
                return []
            case .itemLookUp:
                return []
        }
    }
    

}
