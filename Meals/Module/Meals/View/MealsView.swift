import SwiftUI

struct MealsView: View {
    
    @ObservedObject var presenter: MealsPresenter
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading...")
                    ProgressView()
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    Text("Meals")
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
            if self.presenter.categories.count == 0 {
                self.presenter.fetchCategories()
            }
        }.navigationBarTitle(
            Text("Meals Apps"),
            displayMode: .automatic
        )
    }
    
}
