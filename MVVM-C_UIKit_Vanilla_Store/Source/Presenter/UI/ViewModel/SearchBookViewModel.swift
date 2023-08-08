final class SearchBookViewModel: ViewModelProtocol {
    // MARK: - Stored Property
    private weak var coordinator: BookCoordinator?
    
    // MARK: - Initializer
    init(
        coordinator: BookCoordinator? = nil
    ) {
        self.coordinator = coordinator
    }
}
