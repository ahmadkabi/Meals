import Foundation
import Combine
import RealmSwift

protocol LocaleDataSourceProtocol: AnyObject {
    
    func getCategories() -> AnyPublisher<[CategoryEntity], Error>
    func addCategory(from category: CategoryEntity) -> AnyPublisher<Bool, Error>
    
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
    
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
    func getCategories() -> AnyPublisher<[CategoryEntity], Error> {
        return Future<[CategoryEntity], Error> { completion in
          if let realm = self.realm {
            let categories: Results<CategoryEntity> = {
              realm.objects(CategoryEntity.self)
                .sorted(byKeyPath: "title", ascending: true)
            }()
            completion(.success(categories.toArray(ofType: CategoryEntity.self)))
          } else {
            completion(.failure(DatabaseError.invalidInstance))
          }
        }.eraseToAnyPublisher()
      }
    
    func getCategory(
        id: String,
    ) -> CategoryEntity? {
        if let realm = realm {
            return realm.object(ofType: CategoryEntity.self, forPrimaryKey: id)
        } else {
            return nil
        }
    }
    
    func addCategory(
        from category: CategoryEntity
    ) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(category, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteCategory(
        id: String,
        result: @escaping (Result<Bool, DatabaseError>) -> Void
    ) {
        guard let realm = realm else {
            result(.failure(.invalidInstance))
            return
        }
        
        guard let category = realm.object(
            ofType: CategoryEntity.self,
            forPrimaryKey: id
        ) else {
            result(.success(false))
            return
        }
        
        do {
            try realm.write {
                realm.delete(category)
            }
            
            result(.success(true))
        } catch {
            result(.failure(.requestFailed))
        }
    }
    
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
