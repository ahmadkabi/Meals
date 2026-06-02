//
//  Injection.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import Foundation
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
    
}
