import Foundation

extension Double {
    func string(rounded place: Int) -> String {
        let nsValue: NSNumber = .init(value: self)
        let formatter: NumberFormatter = .init()
        formatter.maximumFractionDigits = place
        
        guard let formattedValue = formatter.string(from: nsValue) else {
            return self.description
        }
        
        return formattedValue
    }
}
