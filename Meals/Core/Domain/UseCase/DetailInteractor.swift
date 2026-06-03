import Foundation

protocol DetailUseCase {
    
    func getCategory() -> CategoryModel
    func isFavorite() -> Bool
    func favoriteCategory(category: CategoryModel)
    func unfavoriteCategory(category: CategoryModel)
    
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
    
    func favoriteCategory(category: CategoryModel) {
        repository.favoriteCategory(
            categoryEntity: CategoryMapper.mapCategoryDomainToEntity(input: category)
        ){ _ in
        }
    }

    func unfavoriteCategory(category: CategoryModel) {
        repository.unfavoriteCategory(
            categoryEntity: CategoryMapper.mapCategoryDomainToEntity(input: category)
        ){ _ in
        }
    }
    
}
