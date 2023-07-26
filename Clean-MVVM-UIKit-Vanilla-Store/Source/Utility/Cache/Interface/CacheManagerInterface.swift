protocol CacheManager {
    associatedtype ObjectType
        
    func getObject(for key: String) -> ObjectType?
    func setObject(_ object: ObjectType, for key: String)
    func removeObject(for key: String)
    func removeAllObjects()
}
