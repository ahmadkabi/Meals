import Foundation
import Combine
import Category

protocol DetailUseCase {
    
    func getCategory() -> CategoryModel
    func isFavorite() -> Bool
    func favoriteCategory(category: CategoryModel) -> AnyPublisher<Bool, Error>
    func unfavoriteCategory(category: CategoryModel) -> AnyPublisher<Bool, Error>
    
}

class DetailInteractor: DetailUseCase {
    
    private let repository: MealRepositoryProtocol
    private let category: CategoryModel
    
    required init(
        repository: MealRepositoryProtocol,
        category: CategoryModel
    ) {
        self.repository = repository
        self.category = category
    }
    
    func getCategory() -> CategoryModel {
      return category
    }
    
    func isFavorite() -> Bool {
        return repository.getCategory(id: category.id) != nil
    }
    
    func favoriteCategory(category: CategoryModel) -> AnyPublisher<Bool, Error> {
        return repository.favoriteCategory(
            categoryEntity: CategoryMapper.mapCategoryDomainToEntity(input: category)
        )
    }
    
    func unfavoriteCategory(category: CategoryModel) -> AnyPublisher<Bool, Error> {
        return repository.unfavoriteCategory(id: category.id)
    }
    
}
