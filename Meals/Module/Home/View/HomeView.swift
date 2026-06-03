import SwiftUI

struct HomeView: View {
    
    @ObservedObject var mealsPresenter: MealsPresenter
    @ObservedObject var favoritePresenter: FavoritePresenter
    @ObservedObject var aboutPresenter: AboutPresenter
    
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                MealsView(presenter: mealsPresenter)
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
