import Foundation

protocol MealsUseCase {

  func fetchCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)

}

class MealsInteractor: MealsUseCase {

  private let repository: MealRepositoryProtocol

  required init(repository: MealRepositoryProtocol) {
    self.repository = repository
  }

  func fetchCategories(
    completion: @escaping (Result<[CategoryModel], Error>) -> Void
  ) {
    repository.fetchCategories { result in
      completion(result)
    }
  }

}
