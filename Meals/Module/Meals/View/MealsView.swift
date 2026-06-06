import SwiftUI
import Core
import Category

struct MealsView: View {
    
    @ObservedObject var presenter: GetListPresenter<Any, CategoryModel, Interactor<Any, [CategoryModel], GetCategoriesRepository<GetCategoriesLocaleDataSource, GetCategoriesRemoteDataSource, CategoryTransformer>>>
    
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
                //todo last here compare getlist & fetchCategories
                //                self.presenter.fetchCategories()
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
        destination: MealsRouter().makeDetailView(for: category)
      ) { content() }
    }
    
}
