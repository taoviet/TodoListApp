//
//  Plist.swift
//  TodoList
//
//  Created by Huy on 3/10/19.
//  Copyright © 2019 Long. All rights reserved.
//

import Foundation

struct InfoPlist: Decodable {
    let baseURL: String
    
    enum CodingKeys: String, CodingKey {
        case baseURL = "Api base url"
    }
}

extension Bundle {
    static let infoPlist: InfoPlist! = {
        guard let url = main.url(forResource: "Info", withExtension: "plist"), let data = try? Data(contentsOf: url) else { return nil }
        do {
            return try PropertyListDecoder().decode(InfoPlist.self, from: data)
        } catch {
            print("BUG: \(error)")
        }
        return nil
    }()
    
}
