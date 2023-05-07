//
//  AuthGetUserClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 06/05/23.
//

import Foundation

public protocol AuthGetUserClient {
    func getUser() -> UserModel?
}
