final class AsyncManager {
    // MARK: - Stored Property
    static let shared: AsyncManager = .init()
    
    // MARK: - Initializer
    private init() { }
    
    // MARK: - Method
    func mapConcurrently<T, U: Sendable>(
        from items: [T],
        transform: @escaping (T) async throws -> U
    ) async throws -> [U] {
        var results: [(index: Int, value: U)] = []
            
        try await withThrowingTaskGroup(of: (Int, U).self) { group in
            for (index, item) in items.enumerated() {
                group.addTask {
                    return try await (index, transform(item))
                }
            }
            
            for try await result in group {
                results.append(result)
            }
        }
        
        return results
            .sorted { $0.index < $1.index }
            .map { $0.value }
    }
}
