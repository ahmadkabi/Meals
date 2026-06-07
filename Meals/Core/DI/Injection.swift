import Foundation
import Core
import Category
import RealmSwift

final class Injection: NSObject {
    
    private func provideRepository() -> MealRepositoryProtocol {
        let realm = try? Realm()
        
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return MealRepository.sharedInstance(locale, remote)
    }
    
    func provideMeals() -> MealsUseCase {
        let repository = provideRepository()
        return MealsInteractor(repository: repository)
    }
    
    func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
    
    func provideDetail(category: CategoryModel) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository, category: category)
    }
    
    private let realm = try? Realm()
    
    func provideFetchCategoriesInteractor<U: UseCase>() -> U where U.Request == Any, U.Response == [CategoryModel] {
        let remote = GetCategoriesRemoteDataSource(endpoint: Endpoints.Gets.categories.url)
        let mapper = CategoryTransformer()
        let repository = FetchCategoriesRepository(
            remoteDataSource: remote,
            mapper: mapper
        )
        return Interactor(repository: repository) as! U
    }
    
    func provideGetCategoriesInteractor<U: UseCase>() -> U where U.Request == Any, U.Response == [CategoryModel] {
        let locale = GetCategoriesLocaleDataSource(realm: realm!)
        let mapper = CategoryTransformer()
        let repository = GetCategoriesRepository(
            localeDataSource: locale,
            mapper: mapper
        )
        return Interactor(repository: repository) as! U
    }
    
}
