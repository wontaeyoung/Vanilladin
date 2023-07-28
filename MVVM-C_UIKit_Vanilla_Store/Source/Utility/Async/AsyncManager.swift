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
        var results: [U] = []
        
        try await withThrowingTaskGroup(of: U.self) { group in
            for item in items {
                group.addTask {
                    print("Task: ",(item as? BookDTO)?.title)
                    return try await transform(item)
                }
            }
            
            for try await result in group {
                print("Result :", (result as? Book)?.title)
                results.append(result)
            }
        }
        
        print("All Task Done")
        return results
    }
}
