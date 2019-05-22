//
//  Json.swift
//  BikeShare
//
//  Created by Luiz on 5/22/19.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import Foundation

@objc public class Json: NSObject, Codable {

    var last_updated : Date
    var data: DataClass

    public class func create(from url: URL) -> Json {
        let decoder = JSONDecoder()
        let item = try! decoder.decode(Json.self, from: try! Data(contentsOf: url))
        return item
    }

    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
