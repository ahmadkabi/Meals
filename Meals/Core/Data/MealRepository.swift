import Foundation
import Combine
import Category

protocol MealRepositoryProtocol {
    
    func getCategory(id: String) -> CategoryModel?
    func favoriteCategory(categoryEntity: CategoryEntity) -> AnyPublisher<Bool, Error>
    func unfavoriteCategory(id: String) -> AnyPublisher<Bool, Error>
    
}

final class MealRepository: NSObject {
    
    typealias MealInstance = (LocaleDataSource) -> MealRepository
    
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource) {
        self.locale = locale
    }
    
    static let sharedInstance: MealInstance = { localeRepo in
        return MealRepository(locale: localeRepo)
    }
    
}

extension MealRepository: MealRepositoryProtocol {
    
    func favoriteCategory(categoryEntity: CategoryEntity) -> AnyPublisher<Bool, Error>{
        return self.locale.addCategory(from: categoryEntity)
        .map { $0 }
        .eraseToAnyPublisher()
    }
    
    func unfavoriteCategory(id: String) -> AnyPublisher<Bool, Error>{
        return self.locale.deleteCategory(id: id)
        .map { $0 }
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
