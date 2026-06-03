import Foundation
import Combine

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
        return repository.getCategories()
    }
    
    func favoriteCategory(categoryEntity: CategoryEntity) -> AnyPublisher<Bool, Error> {
        return repository.favoriteCategory(categoryEntity: categoryEntity)
    }
    
    
    
}
