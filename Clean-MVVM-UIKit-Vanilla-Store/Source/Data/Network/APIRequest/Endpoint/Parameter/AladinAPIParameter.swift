enum AladinAPIParameter: String {
    case ttbKey
    case QueryType
    case Cover
    case Output
    case Version
    case Query
    case Start
    
    var name: String {
        return self.rawValue
    }
}
