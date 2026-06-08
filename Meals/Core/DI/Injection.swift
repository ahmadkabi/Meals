import Foundation
import Core
import Category
import RealmSwift

final class Injection: NSObject {
    
    private let realm = try? Realm()
    
     
    func provideFetchCategoriesInteractor<U: UseCase>() -> U where U.Request == Any, U.Response == [CategoryModel] {
        let remote = GetCategoriesRemoteDataSource(endpoint: Endpoints.Gets.categories.url)
        let mapper = CategoriesTransformer()
        let repository = FetchCategoriesRepository(
            remoteDataSource: remote,
            mapper: mapper
        )
        return Interactor(repository: repository) as! U
    }
    
    func provideGetCategoriesInteractor<U: UseCase>() -> U where U.Request == Any, U.Response == [CategoryModel] {
        let locale = GetCategoriesLocaleDataSource(realm: realm!)
        let mapper = CategoriesTransformer()
        let repository = GetCategoriesRepository(
            localeDataSource: locale,
            mapper: mapper
        )
        return Interactor(repository: repository) as! U
    }
    
    func provideGetIsFavoriteInteractor<U: UseCase>() -> U where U.Request == String, U.Response == Bool {
        let locale = IsFavoriteDataSource(realm: realm!)
        let repository = GetIsFavoriteRepository(
            localeDataSource: locale,
        )
        return Interactor(repository: repository) as! U
    }
    
    func provideFavoriteCategoryInteractor<U: UseCase>() -> U where U.Request == CategoryModel, U.Response == Bool {
        let locale = FavoriteCategoryDataSource(realm: realm!)
        let mapper = CategoryTransformer()
        let repository = FavoriteCategoryRepository(
            localeDataSource: locale,
            mapper: mapper
        )
        return Interactor(repository: repository) as! U
    }
    
    func provideUnfavoriteCategoryInteractor<U: UseCase>() -> U where U.Request == String, U.Response == Bool {
        let locale = UnfavoriteCategoryDataSource(realm: realm!)
        let repository = UnfavoriteCategoryRepository(
            localeDataSource: locale,
        )
        return Interactor(repository: repository) as! U
    }
    
}
