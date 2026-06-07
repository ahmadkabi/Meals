import Foundation
import Combine
import Category

protocol MealsUseCase {
    
}

class MealsInteractor: MealsUseCase {
    
    private let repository: MealRepositoryProtocol
    
    required init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }
}
