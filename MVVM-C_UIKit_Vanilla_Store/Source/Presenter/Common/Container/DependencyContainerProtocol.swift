protocol DependencyContainerProtocol: DependencyContainable {
    func register<T: DependencyContainable>(
        instance: T
    )
    
    /**
     register에 원하는 인스턴스가 존재하지 않는 경우, factory에 전달한 클로저로 인스턴스를 등록 후 리턴할 수 있습니다.
     */
    func resolve<T: DependencyContainable>(
        _ factory: @escaping () -> T
    ) -> T
    
    func setDependency()
}
