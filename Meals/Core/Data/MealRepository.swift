import Foundation

protocol MealRepositoryProtocol {
    
    func fetchCategories(result: @escaping (Result<[CategoryModel], Error>) -> Void)
    func getCategory(id: String) -> CategoryModel?
    func favoriteCategory(categoryEntity: CategoryEntity, result: @escaping (Result<Bool, DatabaseError>) -> Void)
    func unfavoriteCategory(categoryEntity: CategoryEntity, result: @escaping (Result<Bool, DatabaseError>) -> Void)
    
    //todo : delete
    func getCategories(result: @escaping (Result<[CategoryModel], Error>) -> Void)
    
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
    
    func fetchCategories(
        result: @escaping (Result<[CategoryModel], Error>) -> Void
    ) {
        remote.getCategories { remoteResponses in
            switch remoteResponses {
            case .success(let categoryResponses):
                let resultList = CategoryMapper.mapCategoryResponsesToDomains(input: categoryResponses)
                result(.success(resultList))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func favoriteCategory(categoryEntity: CategoryEntity, result: @escaping (Result<Bool, DatabaseError>) -> Void){
        locale.addFavorite(from: categoryEntity){ addState in
            switch addState {
            case .success(let resultFromAdd):
                result(.success(resultFromAdd))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func unfavoriteCategory(categoryEntity: CategoryEntity, result: @escaping (Result<Bool, DatabaseError>) -> Void){
        locale.deleteFavorite(id: categoryEntity.id){ addState in
            switch addState {
            case .success(let resultFromAdd):
                result(.success(resultFromAdd))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func getCategories(
        result: @escaping (Result<[CategoryModel], Error>) -> Void
    ) {
        locale.getCategories { localeResponses in
            switch localeResponses {
            case .success(let categoryEntity):
                let resultList = CategoryMapper.mapCategoryEntitiesToDomains(input: categoryEntity)
                result(.success(resultList))
            case .failure(let error):
                result(.failure(error))
            }
        }
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
