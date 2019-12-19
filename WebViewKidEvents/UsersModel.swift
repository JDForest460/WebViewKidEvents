//
//  UsersModel.swift
//  WebViewKidEvents
//
//  Created by Jiade Lin on 12/16/19.
//  Copyright © 2019 Jiade Lin. All rights reserved.
//

import Foundation
// MARK: - Welcome
struct UsersModel: Codable {
    let usersaved: [Usersaved]
}
struct BackModel: Codable {
    let back: String
    let id: String
}
// MARK: - Usersaved
struct Usersaved: Codable {
    let savedid: Int
    let title: String
    let url: String
    let userid: String
}
