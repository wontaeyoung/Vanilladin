import Foundation

extension Int {
    var asPriceFormat: String {
        let numberFormatter: NumberFormatter = .init()
        numberFormatter.numberStyle = .decimal
        let nsNumber: NSNumber = .init(value: self)
        
        return numberFormatter.string(from: nsNumber) ?? ""
    }
}
