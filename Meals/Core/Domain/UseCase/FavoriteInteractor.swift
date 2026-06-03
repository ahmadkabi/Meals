import Foundation

protocol FavoriteUseCase {
    
    func getFavorites(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
    func favoriteCategory(
        categoryEntity: CategoryEntity,
        completion: @escaping (Result<Bool, DatabaseError>) -> Void
    )
    
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: MealRepositoryProtocol
    
    required init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavorites(
        completion: @escaping (Result<[CategoryModel], Error>) -> Void
    ) {
        repository.getCategories { result in
            completion(result)
        }
    }
    
    func favoriteCategory(
        categoryEntity: CategoryEntity,
        completion: @escaping (Result<Bool, DatabaseError>) -> Void
    ) {
        repository.favoriteCategory(categoryEntity: categoryEntity) { result in
            completion(result)
        }
    }
    
    
    
}
