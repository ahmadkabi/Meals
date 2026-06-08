import SwiftUI
import Category
import Core

class FavoriteRouter {
    
    let isFavoriteUseCase: Interactor<
        String,
        Bool,
        GetIsFavoriteRepository<IsFavoriteDataSource>
    > = Injection.init().provideGetIsFavoriteInteractor()
    
    let favoriteUseCase : Interactor<
        CategoryModel,
        Bool,
        FavoriteCategoryRepository<FavoriteCategoryDataSource, CategoryTransformer>
    > = Injection.init().provideFavoriteCategoryInteractor()
    
    let unfavoriteUseCase : Interactor<
        String,
        Bool,
        UnfavoriteCategoryRepository<UnfavoriteCategoryDataSource>
    > = Injection.init().provideUnfavoriteCategoryInteractor()
    
    
    func makeDetailView(for category: CategoryModel) -> some View {
        
        let presenter = CategoryDetailPresenter(
            category: category,
            isFavoriteUseCase: isFavoriteUseCase,
            favoriteUseCase: favoriteUseCase,
            unfavoriteUseCase: unfavoriteUseCase,
        )
        
        return DetailView(presenter: presenter)
    }
    
}
