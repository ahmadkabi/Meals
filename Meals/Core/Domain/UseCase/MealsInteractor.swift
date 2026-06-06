import Foundation
import Combine
import Category

protocol MealsUseCase {
    
    func fetchCategories() -> AnyPublisher<[CategoryModel], Error>
    
}

class MealsInteractor: MealsUseCase {
    
    private let repository: MealRepositoryProtocol
    
    required init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchCategories() -> AnyPublisher<[CategoryModel], Error> {
        return repository.fetchCategories()
    }
    
    
    
    
}
