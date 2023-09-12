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
    
    var fixedQueryItems: [URLQueryItem] {
        switch self {
        case .itemSearch:
            return [
                URLQueryItem(
                    name: AladinAPIParameter.ttbKey.name,
                    value: AladinAPIConstant.Common.ttbKey),
                URLQueryItem(
                    name: AladinAPIParameter.Output.name,
                    value: AladinAPIConstant.Common.output),
                URLQueryItem(
                    name: AladinAPIParameter.Version.name,
                    value: AladinAPIConstant.Common.version),
                URLQueryItem(
                    name: AladinAPIParameter.QueryType.name,
                    value: AladinAPIConstant.ItemSearch.queryType),
                URLQueryItem(
                    name: AladinAPIParameter.Cover.name,
                    value: AladinAPIConstant.ItemSearch.cover),
                URLQueryItem(
                    name: AladinAPIParameter.MaxResults.name,
                    value: AladinAPIConstant.ItemSearch.maxResults),
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
                URLQueryItem(
                    name: AladinAPIParameter.Query.name,
                    value: keyword),
                URLQueryItem(
                    name: AladinAPIParameter.Start.name,
                    value: page.description),
            ]
            
        case .itemList:
            return []
            
        case .itemLookUp:
            return []
        }
    }
}
