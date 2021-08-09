//
//  TagsResponse.swift
//  TagsFilter
//
//  Created by Mohamed Ramadan on 08/08/2021.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - TagsResponse
class TagsResponse: Codable {
    let tags: [Tag]

    enum CodingKeys: String, CodingKey {
        case tags = "items"
    }
    
    init(tags: [Tag]) {
        self.tags = tags
    }

    required convenience init(coder aDecoder: NSCoder) {
        let tags = aDecoder.decodeObject(forKey: "tags") as! [Tag]
        self.init(tags: tags)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(tags, forKey: "tags")
    }
}

// MARK: - Tag
class Tag: Codable {
    let owner: Owner
    let viewCount, answerCount: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case owner
        case viewCount = "view_count"
        case answerCount = "answer_count"
        case title
    }
    
    init(owner: Owner, viewCount: Int, answerCount: Int, title: String) {
        self.owner = owner
        self.viewCount = viewCount
        self.answerCount = answerCount
        self.title = title
    }

    required convenience init(coder aDecoder: NSCoder) {
        let viewCount = aDecoder.decodeInteger(forKey: "viewCount")
        let answerCount = aDecoder.decodeInteger(forKey: "answerCount")
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let owner = aDecoder.decodeObject(forKey: "owner") as! Owner
        self.init(owner: owner, viewCount: viewCount, answerCount: answerCount, title: title)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(owner, forKey: "owner")
        aCoder.encode(viewCount, forKey: "viewCount")
        aCoder.encode(answerCount, forKey: "answerCount")
        aCoder.encode(title, forKey: "title")
    }
}

// MARK: - Owner
class Owner: Codable {
    let reputation: Int
    let displayName: String

    enum CodingKeys: String, CodingKey {
        case reputation
        case displayName = "display_name"
    }
}
