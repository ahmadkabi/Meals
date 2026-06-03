import SwiftUI

struct FavoriteView: View {

  @ObservedObject var presenter: FavoritePresenter

  var body: some View {
    ZStack {
      if presenter.loadingState {
        VStack {
          Text("Loading...")
          ProgressView()
        }
      } else {
        ScrollView(.vertical, showsIndicators: false) {
            Text("Favorites")
                .font(.title)
          ForEach(
            self.presenter.categories,
            id: \.id
          ) { category in
            ZStack {
              self.presenter.linkBuilder(for: category) {
                CategoryRow(category: category)
              }.buttonStyle(PlainButtonStyle())
            }.padding(8)
          }
        }
      }
    }.onAppear {
        self.presenter.getCategories()
    }.navigationBarTitle(
      Text("Meals Apps"),
      displayMode: .automatic
    )
  }

}
