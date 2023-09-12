import Foundation

enum AladinAPIEndpoint: EndpointProtocol {
    case itemSearch(keyword: String, page: UInt)
    case itemLookUp(isbn13: String)
    
    var defaultPath: String {
        return "/ttb/api"
    }
    
    var optionalPath: String {
        switch self {
        case .itemSearch:
            return "/ItemSearch.aspx"
            
        case .itemLookUp:
            return "/ItemLookUp.aspx"
        }
    }
    
    var fixedQueryItems: [URLQueryItem] {
        switch self {
        case .itemSearch:
            return [
                URLQueryItem(
                    name: AladinAPIParameter.Common.ttbKey.name,
                    value: AladinAPIConstant.Common.ttbKey),
                URLQueryItem(
                    name: AladinAPIParameter.Common.output.name,
                    value: AladinAPIConstant.Common.output),
                URLQueryItem(
                    name: AladinAPIParameter.Common.version.name,
                    value: AladinAPIConstant.Common.version),
                URLQueryItem(
                    name: AladinAPIParameter.ItemSearch.queryType.name,
                    value: AladinAPIConstant.ItemSearch.queryType),
                URLQueryItem(
                    name: AladinAPIParameter.ItemSearch.cover.name,
                    value: AladinAPIConstant.ItemSearch.cover),
                URLQueryItem(
                    name: AladinAPIParameter.ItemSearch.maxResults.name,
                    value: AladinAPIConstant.ItemSearch.maxResults),
            ]
            
        case .itemLookUp:
            return [
                URLQueryItem(
                    name: AladinAPIParameter.Common.ttbKey.name,
                    value: AladinAPIConstant.Common.ttbKey),
                URLQueryItem(
                    name: AladinAPIParameter.Common.output.name,
                    value: AladinAPIConstant.Common.output),
                URLQueryItem(
                    name: AladinAPIParameter.Common.version.name,
                    value: AladinAPIConstant.Common.version),
                URLQueryItem(
                    name: AladinAPIParameter.ItemLookUp.itemIDType.name,
                    value: AladinAPIConstant.ItemLookUp.itemIDType),
                URLQueryItem(
                    name: AladinAPIParameter.ItemLookUp.optResult.name,
                    value: AladinAPIConstant.ItemLookUp.optResult),
            ]
        }
    }
    
    var optionalQueryItems: [URLQueryItem] {
        switch self {
        case .itemSearch(let keyword, let page):
            return [
                URLQueryItem(
                    name: AladinAPIParameter.ItemSearch.query.name,
                    value: keyword),
                URLQueryItem(
                    name: AladinAPIParameter.ItemSearch.start.name,
                    value: page.description),
            ]
            
        case .itemLookUp(let isbn13):
            return [
                URLQueryItem(
                    name: AladinAPIParameter.ItemLookUp.itemID.name,
                    value: isbn13),
            ]
        }
    }
}
