import Foundation

final class AppConfigManager {
    func getValue<T>(forKey key: String) -> T? {
        guard
            let path = Bundle.main.path(
                forResource: LogicConstant.Plist.apiKeyFileName,
                ofType: LogicConstant.Plist.FileType.plist),
            let dict = NSDictionary(contentsOfFile: path)
        else {
            return nil
        }
        
        return dict[key] as? T
    }
}
