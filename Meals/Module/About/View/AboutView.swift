import SwiftUI
import CachedAsyncImage

struct AboutView: View {
    @ObservedObject var presenter: AboutPresenter
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                title
                spacer.frame(height: 200)
                picture
                spacer.frame(height: 20)
                content
                spacer
            }.padding()
        }
    }
}

extension AboutView {
    var spacer: some View {
        Spacer()
    }
    
    var picture: some View {
        Image(self.presenter.picture)
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .clipShape(Circle())
    }
    
    var title: some View {
        Text("About")
            .font(.title)
    }
    var content: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(self.presenter.name)
                .font(.title3)
            Text(self.presenter.email)
              .font(.body)
        }
    }
}
