import SwiftUI
import Core
import Category

struct ContentView: View {
    @EnvironmentObject var mealsPresenter: GetListPresenter<Any, CategoryModel, Interactor<Any, [CategoryModel], FetchCategoriesRepository<GetCategoriesRemoteDataSource, CategoriesTransformer>>>
    @EnvironmentObject var favoritePresenter: GetListPresenter<Any, CategoryModel, Interactor<Any, [CategoryModel], GetCategoriesRepository<GetCategoriesLocaleDataSource, CategoriesTransformer>>>
    @EnvironmentObject var aboutPresenter: AboutPresenter
    
    var body: some View {
        NavigationStack {
            HomeView(
                categoriesPresenter: mealsPresenter,
                favoritePresenter: favoritePresenter,
                aboutPresenter: aboutPresenter,
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
