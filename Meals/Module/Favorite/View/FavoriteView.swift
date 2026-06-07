import SwiftUI
import Core
import Category

struct FavoriteView: View {
    
    @ObservedObject var presenter: GetListPresenter<Any, CategoryModel, Interactor<Any, [CategoryModel], GetCategoriesRepository<GetCategoriesLocaleDataSource, CategoryTransformer>>>
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                VStack {
                    Text("Loading...")
                    ProgressView()
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    Text("Favorites")
                        .font(.title)
                    ForEach(
                        self.presenter.list,
                        id: \.id
                    ) { category in
                        linkBuilder(for: category) {
                          CategoryRow(category: category)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }.onAppear {
            self.presenter.getList(request: nil)
        }.navigationBarTitle(
            Text("Meals Apps"),
            displayMode: .automatic
        )
    }
    
    func linkBuilder<Content: View>(
      for category: CategoryModel,
      @ViewBuilder content: () -> Content
    ) -> some View {

      NavigationLink(
        destination: CategoriesRouter().makeDetailView(for: category)
      ) { content() }
    }
    
}
