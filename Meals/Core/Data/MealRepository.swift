import Foundation
import Combine

protocol MealRepositoryProtocol {
    
    func fetchCategories() -> AnyPublisher<[CategoryModel], Error>
    func getCategory(id: String) -> CategoryModel?
    func favoriteCategory(categoryEntity: CategoryEntity) -> AnyPublisher<Bool, Error>
    func unfavoriteCategory(categoryEntity: CategoryEntity, result: @escaping (Result<Bool, DatabaseError>) -> Void)
    func getCategories() -> AnyPublisher<[CategoryModel], Error>
    
}

final class MealRepository: NSObject {
    
    typealias MealInstance = (LocaleDataSource, RemoteDataSource) -> MealRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let sharedInstance: MealInstance = { localeRepo, remoteRepo in
        return MealRepository(locale: localeRepo, remote: remoteRepo)
    }
    
}

extension MealRepository: MealRepositoryProtocol {
    
    func fetchCategories() -> AnyPublisher<[CategoryModel], Error> {
        return self.remote.getCategories()
            .map { CategoryMapper.mapCategoryResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func favoriteCategory(categoryEntity: CategoryEntity) -> AnyPublisher<Bool, Error>{
        return self.locale.addCategory(from: categoryEntity)
        .map { $0 }
        .eraseToAnyPublisher()
    }
    
    func unfavoriteCategory(categoryEntity: CategoryEntity, result: @escaping (Result<Bool, DatabaseError>) -> Void){
        locale.deleteCategory(id: categoryEntity.id){ addState in
            switch addState {
            case .success(let resultFromAdd):
                result(.success(resultFromAdd))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func getCategories() -> AnyPublisher<[CategoryModel], Error> {
        return self.locale.getCategories()
        .map { CategoryMapper.mapCategoryEntitiesToDomains(input: $0) }
        .eraseToAnyPublisher()
    }
    
    func getCategory(
        id: String
    ) -> CategoryModel? {
        if let categoryEntity = locale.getCategory(id: id){
            return CategoryMapper.mapCategoryEntityToDomain(input: categoryEntity)
        }else{
            return nil
        }
        
    }
}
