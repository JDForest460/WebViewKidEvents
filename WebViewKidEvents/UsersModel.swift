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

// MARK: - Usersaved
struct Usersaved: Codable {
    let savedid: Int
    let title: String
    let url: String
    let userid: String
}
