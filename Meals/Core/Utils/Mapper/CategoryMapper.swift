import Foundation

final class CategoryMapper {
    
    static func mapCategoryResponsesToEntities(
        input categoryResponses: [CategoryResponse]
    ) -> [CategoryEntity] {
        return categoryResponses.map { result in
            let newCategory = CategoryEntity()
            newCategory.id = result.id ?? ""
            newCategory.title = result.title ?? "Unknow"
            newCategory.image = result.image ?? "Unknow"
            newCategory.desc = result.description ?? "Unknow"
            return newCategory
        }
    }
    
    static func mapCategoryEntitiesToDomains(
        input categoryEntities: [CategoryEntity]
    ) -> [CategoryModel] {
        return categoryEntities.map { result in
            return CategoryModel(
                id: result.id,
                title: result.title,
                image: result.image,
                description: result.desc
            )
        }
    }
    
    static func mapCategoryEntityToDomain(
        input categoryEntity: CategoryEntity
    ) -> CategoryModel {
        return CategoryModel(
            id: categoryEntity.id,
            title: categoryEntity.title,
            image: categoryEntity.image,
            description: categoryEntity.desc
        )
    }
    
    static func mapCategoryDomainToEntity(
        input categoryModel: CategoryModel
    ) -> CategoryEntity {
        let newCategory = CategoryEntity()
        newCategory.id = categoryModel.id
        newCategory.title = categoryModel.title
        newCategory.image = categoryModel.image
        newCategory.desc = categoryModel.description
        return newCategory
    }
    
    static func mapCategoryResponsesToDomains(
        input categoryResponses: [CategoryResponse]
    ) -> [CategoryModel] {
        
        return categoryResponses.map { result in
            return CategoryModel(
                id: result.id ?? "",
                title: result.title ?? "Unknow",
                image: result.image ?? "Unknow",
                description: result.description ?? "Unknow"
            )
        }
    }
    
}
