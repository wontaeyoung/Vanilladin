extension Array {
    func element(at index: Int) -> Element? {
        guard index < self.count else {
            return nil
        }
        
        return self[index]
    }
    
    mutating func safeRemove(at index: Int) {
        guard 
            0 <= index,
            index < self.count
        else {
            return
        }
        
        self.remove(at: index)
    }
}
