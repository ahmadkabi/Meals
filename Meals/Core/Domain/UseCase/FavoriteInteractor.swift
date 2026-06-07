import Foundation
import Combine
import Category

protocol FavoriteUseCase {
    
    func favoriteCategory(
        categoryEntity: CategoryEntity
    ) -> AnyPublisher<Bool, Error> 
    
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: MealRepositoryProtocol
    
    required init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }
    
    func favoriteCategory(categoryEntity: CategoryEntity) -> AnyPublisher<Bool, Error> {
        return repository.favoriteCategory(categoryEntity: categoryEntity)
    }
    
    
    
}
