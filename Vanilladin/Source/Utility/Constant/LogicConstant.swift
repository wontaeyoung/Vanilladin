enum LogicConstant {
    enum Plist {
        static let apiKeyFileName: String = "API_KEY"
        static let ttbKey: String = "TTB_KEY"
        
        enum FileType {
            static let plist: String = "plist"
        }
    }
    
    enum UserDefault {
        static let searchKeywordKey: String = "SearchKeyword"
        static let maxKeywordCount: Int = 5
    }
}