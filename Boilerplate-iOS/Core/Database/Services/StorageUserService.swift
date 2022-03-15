//
//  StorageUserService.swift
//  Boilerplate-iOS
//
//  Created by Tang Tuan on 3/15/22.
//

protocol StorageUserUseCase: AnyObject {
    func allUser() -> [User]
    func saveUser(element: User)
    func findUser(by id: Int) -> User?
}

extension StorageUserUseCase {
    fileprivate var repo: Repository<User> {
        Repository<User>()
    }
    
    func allUser() -> [User] {
        repo.queryAll().compactMap { elment in
            return elment
        }
    }
    
    func saveUser(element: User) {
        repo.addObject(entity: element)
    }
    
    func findUser(by id: Int) -> User? {
        repo.queryObject(by: "\(id)")
    }
}

class StorageUserService: StorageUserUseCase {
    public static let `default`: StorageUserUseCase = {
        var service = StorageUserService()
        return service
    }()
}
