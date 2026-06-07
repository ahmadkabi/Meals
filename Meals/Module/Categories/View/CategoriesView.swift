import SwiftUI
import Core
import Category

struct CategoriesView: View {
    
    @ObservedObject var presenter: GetListPresenter<Any, CategoryModel, Interactor<Any, [CategoryModel], FetchCategoriesRepository<GetCategoriesRemoteDataSource, CategoryTransformer>>>
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                VStack {
                    Text("Loading...")
                    ProgressView()
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    Text("Meals")
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
            if self.presenter.list.count == 0 {
                self.presenter.getList(request: nil)
            }
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
