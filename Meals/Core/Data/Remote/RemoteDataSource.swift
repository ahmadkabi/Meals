import Foundation
import Combine
import Alamofire

protocol RemoteDataSourceProtocol: AnyObject {
    
    func fetchCategories() -> AnyPublisher<[CategoryResponse], Error>
    
}
final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func fetchCategories() -> AnyPublisher<[CategoryResponse], Error> {
        return Future<[CategoryResponse], Error> { completion in
          if let url = URL(string: Endpoints.Gets.categories.url) {
            AF.request(url)
              .validate()
              .responseDecodable(of: CategoriesResponse.self) { response in
                switch response.result {
                case .success(let value):
                  completion(.success(value.categories))
                case .failure:
                  completion(.failure(URLError.invalidResponse))
                }
              }
          }
        }.eraseToAnyPublisher()
      }
    
}
