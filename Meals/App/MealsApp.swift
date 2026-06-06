import SwiftUI
import Core
import Category

let categoryUseCase: Interactor<
    Any,
    [CategoryModel],
    GetCategoriesRepository<
        GetCategoriesLocaleDataSource,
        GetCategoriesRemoteDataSource,
        CategoryTransformer>
> = Injection.init().provideCategory()

@main
struct MealsApp: App {
    let mealsPresenter = GetListPresenter(useCase: categoryUseCase)
    let favoritePresenter = FavoritePresenter(favoriteUseCase: Injection.init().provideFavorite())
    let aboutPresenter = AboutPresenter()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mealsPresenter)
                .environmentObject(favoritePresenter)
                .environmentObject(aboutPresenter)
        }
    }
}
