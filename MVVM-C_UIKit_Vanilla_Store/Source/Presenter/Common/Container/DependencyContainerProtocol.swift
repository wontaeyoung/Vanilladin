protocol DependencyContainerProtocol: DependencyContainable {
    func register<T: DependencyContainable>(
        instance: T
    )
    
    // register에 원하는 인스턴스가 존재하지 않는 경우, 클로저로 전달받은 인스턴스를 등록 후 리턴할 수 있음
    func resolve<T: DependencyContainable>(
        _ factory: @escaping () -> T
    ) -> T
}
