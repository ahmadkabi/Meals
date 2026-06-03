import SwiftUI
import Combine

class DetailPresenter: ObservableObject {
    
    private let detailUseCase: DetailUseCase
    private var cancellables: Set<AnyCancellable> = []
    
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
            isFavorite = !isFavorite
        }else{
            detailUseCase.favoriteCategory(category: category)
                .receive(on: RunLoop.main)
                .sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .failure:
                            self.errorMessage = String(describing: completion)
                        case .finished:
                            self.loadingState = false
                        }
                    },
                    receiveValue: { isSuccess in
                        if isSuccess{
                            self.isFavorite = !self.isFavorite
                        }
                    }
                )
                .store(in: &cancellables)
            
        }
        
    }
    
}
