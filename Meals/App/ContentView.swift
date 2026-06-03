import SwiftUI

struct ContentView: View {
  @EnvironmentObject var mealsPresenter: MealsPresenter
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
