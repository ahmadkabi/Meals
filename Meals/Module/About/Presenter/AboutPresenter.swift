import SwiftUI

class AboutPresenter: ObservableObject {

  @Published var picture: String = "ProfilePicture"
  @Published var name: String = "Ahmad Ka'bi"
  @Published var email: String = "ahmadkabi.dev@gmail.com"

}
