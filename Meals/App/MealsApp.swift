import SwiftUI

@main
struct MealsApp: App {
  let mealsPresenter = MealsPresenter(mealsUseCase: Injection.init().provideMeals())
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
