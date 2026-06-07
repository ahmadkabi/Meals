import SwiftUI
import Core
import Category

struct HomeView: View {
    
    @ObservedObject var categoriesPresenter: GetListPresenter<Any, CategoryModel, Interactor<Any, [CategoryModel], FetchCategoriesRepository<GetCategoriesRemoteDataSource, CategoryTransformer>>>
    @ObservedObject var favoritePresenter: GetListPresenter<Any, CategoryModel, Interactor<Any, [CategoryModel], GetCategoriesRepository<GetCategoriesLocaleDataSource, CategoryTransformer>>>
    @ObservedObject var aboutPresenter: AboutPresenter
    
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                CategoriesView(presenter: categoriesPresenter)
                    .tabItem {
                        Image(systemName: "fork.knife")
                        Text("Meals")
                    }
                    .tag(0)
                
                FavoriteView(presenter: favoritePresenter)
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Favorite")
                    }
                    .tag(1)
                
                AboutView(presenter: aboutPresenter)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("About")
                    }
                    .tag(2)
            }
        }
    }
    
}
