//
//  TheMealsAppApp.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import SwiftUI

@main
struct MealsApp: App {
  let mealsPresenter = MealsPresenter(mealsUseCase: Injection.init().provideMeals())
  let favoritePresenter = FavoritePresenter(favoriteUseCase: Injection.init().provideFavorite())

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(mealsPresenter)
        .environmentObject(favoritePresenter)
    }
  }
}
