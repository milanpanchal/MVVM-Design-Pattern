//
//  User.swift
//  MVVM
//
//  Created by Milan Panchal on 19/03/20.
//  Copyright © 2020 Jeenal Infotech. All rights reserved.
//

import UIKit

struct UserList: Codable {
    let results: [User]
}

struct User: Codable {

    let gender: String
    let name: Name
    let email: String
    let picture: Picture
    let nat: String
    let cell: String
    let phone: String
}


struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct DOB:Codable {
    let date: String
    let age: Int
}

struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}
