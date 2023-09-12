enum AladinAPIParameter {
    enum Common: String {
        case ttbKey
        case version
        case output
        
        var name: String {
            return self.rawValue
        }
    }
    
    enum ItemSearch: String {
        case queryType
        case cover
        case query
        case start
        case maxResults
        
        var name: String {
            return self.rawValue
        }
    }
    
    enum ItemLookUp: String {
        case itemID
        case itemIDType
        case optResult
        
        var name: String {
            return self.rawValue
        }
    }
}
