import SwiftUI
import Core
import Category

struct ContentView: View {
    @EnvironmentObject var mealsPresenter: GetListPresenter<Any, CategoryModel, Interactor<Any, [CategoryModel], GetCategoriesRepository<GetCategoriesLocaleDataSource, GetCategoriesRemoteDataSource, CategoryTransformer>>>
    @EnvironmentObject var favoritePresenter: FavoritePresenter
    @EnvironmentObject var aboutPresenter: AboutPresenter
    
    var body: some View {
        NavigationStack {
            HomeView(
                mealsPresenter: mealsPresenter,
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
