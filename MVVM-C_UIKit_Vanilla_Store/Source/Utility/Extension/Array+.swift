extension Array {
    func element(at index: Int) -> Element? {
        guard index < self.count else {
            return nil
        }
        
        return self[index]
    }
}
