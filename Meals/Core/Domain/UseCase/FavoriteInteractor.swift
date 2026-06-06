import Foundation
import Combine
import Category

protocol FavoriteUseCase {
    
    func getFavorites() -> AnyPublisher<[CategoryModel], Error>
    func favoriteCategory(
        categoryEntity: CategoryEntity
    ) -> AnyPublisher<Bool, Error> 
    
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: MealRepositoryProtocol
    
    required init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavorites() -> AnyPublisher<[CategoryModel], Error> {
        return repository.getFavorites()
    }
    
    func favoriteCategory(categoryEntity: CategoryEntity) -> AnyPublisher<Bool, Error> {
        return repository.favoriteCategory(categoryEntity: categoryEntity)
    }
    
    
    
}
