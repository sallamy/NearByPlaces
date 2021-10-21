//
//  Place.swift
//  CamListTask
//
//  Created by mohamed salah on 10/21/21.
//

import Foundation

struct RootModel: Codable {
    let response: ResponseModel?
}

struct ResponseModel: Codable {
    let groups: [group]?
}

struct group: Codable {
    let items: [Item]?
}

struct Item: Codable {
    let venue: venue?
}

struct venue: Codable {
    let id: String?
    let name: String?
    let location: Location?
}

struct Location: Codable {
    let neighborhood: String?
    let city: String?
    let state: String?
    let country: String?
    let contextLine: String?
}

extension Location {
    var address: String {
        return ((country ?? "") + (city ?? "") + (state ?? "") + (neighborhood ?? "") )
    }
}
