enum AladinAPIParameter: String {
    case ttbKey
    case QueryType
    case Cover
    case Output
    case Version
    case Query
    case Start
    case MaxResults
    
    var name: String {
        return self.rawValue
    }
}
