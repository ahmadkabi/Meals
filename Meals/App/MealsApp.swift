import SwiftUI
import Core
import Category

let fetchCategoriesUseCase: Interactor<
    Any,
    [CategoryModel],
    FetchCategoriesRepository<
        GetCategoriesRemoteDataSource,
        CategoryTransformer>
> = Injection.init().provideFetchCategoriesInteractor()

let getCategoriesUseCase: Interactor<
    Any,
    [CategoryModel],
    GetCategoriesRepository<
        GetCategoriesLocaleDataSource,
        CategoryTransformer>
> = Injection.init().provideGetCategoriesInteractor()

@main
struct MealsApp: App {
    let mealsPresenter = GetListPresenter(useCase: fetchCategoriesUseCase)
    let favoritePresenter = GetListPresenter(useCase: getCategoriesUseCase)
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
