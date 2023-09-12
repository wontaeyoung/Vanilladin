import Foundation

enum AladinAPIConstant {
    enum Common {
        static let ttbKey: String? = ProcessInfo.processInfo.environment["TTB_KEY"]
        static let output: String = "JS"
        static let version: String = "20131101"
    }
    
    enum ItemSearch {
        static let queryType: String = "Title"
        static let cover: String = "Big"
        static let maxResults: String = "10"
    }
    
    enum ItemLookUp {
        static let itemIDType: String = "ISBN13"
        static let optResult: String = "ratingInfo,packing"
    }
}
