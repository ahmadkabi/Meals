import SwiftUI

struct HomeView: View {
    
    @ObservedObject var mealsPresenter: MealsPresenter
    @ObservedObject var favoritePresenter: FavoritePresenter
    
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                MealsView(presenter: mealsPresenter)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
                
                FavoriteView(presenter: favoritePresenter)
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Favorite")
                    }
                    .tag(1)
                
                AboutView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("About")
                    }
                    .tag(2)
            }
        }.navigationBarTitle(
            Text("Meals Apps"),
            displayMode: .automatic
        )
    }
    
}
