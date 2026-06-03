import SwiftUI
import CachedAsyncImage

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
                loadingIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        imageCategory
                        spacer
                        content
                        spacer
                    }.padding()
                }
            }
        }
        .navigationBarTitle(Text(self.presenter.category.title), displayMode: .large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    presenter.onFavoriteClicked()
                } label: {
                    Image(systemName: presenter.isFavorite ? "heart.fill" : "heart")
                           .foregroundStyle(presenter.isFavorite ? .red : .primary)
                }
            }
        }
    }
}

extension DetailView {
    var spacer: some View {
        Spacer()
    }
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ProgressView()
        }
    }
    
    var imageCategory: some View {
        CachedAsyncImage(url: URL(string: self.presenter.category.image)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .cornerRadius(30)
        .scaledToFit().frame(width: 250.0, height: 250.0, alignment: .center)
    }
    
    var description: some View {
        Text(self.presenter.category.description)
            .font(.system(size: 15))
    }
    
    func headerTitle(_ title: String) -> some View {
        return Text(title)
            .font(.headline)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerTitle("Description")
                .padding([.top, .bottom])
            description
        }
    }
}
