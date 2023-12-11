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
    
    enum ISBN13 {
        static let favoriteBook: String = "9788970128085"
    }
    
    enum CoreData {
        static let fileName: String = "Vanilladin"
    }
}
