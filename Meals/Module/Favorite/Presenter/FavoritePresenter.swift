//
//  FavoritePresenter.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import SwiftUI

class FavoritePresenter: ObservableObject {

  private let router = FavoriteRouter()
  private let favoriteUseCase: FavoriteUseCase

  @Published var categories: [CategoryModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(favoriteUseCase: FavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }

  func getCategories() {
    loadingState = true
    favoriteUseCase.getCategories { result in
      switch result {
      case .success(let categories):
        DispatchQueue.main.async {
          self.loadingState = false
          self.categories = categories
        }
      case .failure(let error):
        DispatchQueue.main.async {
          self.loadingState = false
          self.errorMessage = error.localizedDescription
        }
      }
    }
  }

  func linkBuilder<Content: View>(
    for category: CategoryModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
    destination: router.makeDetailView(for: category)) { content() }
  }

}
