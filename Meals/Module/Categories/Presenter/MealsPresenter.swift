import SwiftUI
import Combine
import Category

class MealsPresenter: ObservableObject {
    
    private let router = MealsRouter()
    private let mealsUseCase: MealsUseCase
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var categories: [CategoryModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(mealsUseCase: MealsUseCase) {
        self.mealsUseCase = mealsUseCase
    }
    
    func fetchCategories() {
        loadingState = true
        mealsUseCase.fetchCategories()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { categories in
                self.categories = categories
            })
            .store(in: &cancellables)
    }
    
//    func linkBuilder<Content: View>(
//        for category: CategoryDomainModel,
//        @ViewBuilder content: () -> Content
//    ) -> some View {
//        NavigationLink(
//            destination: router.makeDetailView(for: category)) { content() }
//    }
//    
}
