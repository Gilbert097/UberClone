//
//  RemoteAddUser.swift
//  UberClone
//
//  Created by Gilberto Silva on 07/05/23.
//

import Foundation

public class RemoteAddUser: AddUser {
    
    private let setValueClient: DatabaseSetValueClient
    
    public init(setValueClient: DatabaseSetValueClient) {
        self.setValueClient = setValueClient
    }
    
    public func add(id: String, addUserModel: AddUserModel, completion: @escaping (AddUser.Result) -> Void) {
        guard let data = addUserModel.toData() else { return completion(.failure(.unexpected)) }
        self.setValueClient.setValue(path: "users", id: id, data: data) { setValueResult in
            switch setValueResult {
            case .success:
                completion(.success(()))
            case .failure(_):
                completion(.failure(.unexpected))
            }
        }
    }
}
