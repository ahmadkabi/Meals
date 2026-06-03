import SwiftUI

class DetailPresenter: ObservableObject {
    
    private let detailUseCase: DetailUseCase
    
    @Published var isFavorite: Bool = false
    @Published var category: CategoryModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        category = detailUseCase.getCategory()
        getIsFavorite()
    }
    
    func getIsFavorite() {
        isFavorite = detailUseCase.isFavorite()
    }
    
    func onFavoriteClicked(){
        if(isFavorite){
            detailUseCase.unfavoriteCategory(category: category)
        }else{
            detailUseCase.favoriteCategory(category: category)
        }
        isFavorite = !isFavorite
    }
    
}
