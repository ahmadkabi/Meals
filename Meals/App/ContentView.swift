//
//  ContentView.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var mealsPresenter: MealsPresenter
  @EnvironmentObject var favoritePresenter: FavoritePresenter

  var body: some View {
    NavigationStack {
      HomeView(
        mealsPresenter: mealsPresenter,
        favoritePresenter: favoritePresenter,
      )
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
