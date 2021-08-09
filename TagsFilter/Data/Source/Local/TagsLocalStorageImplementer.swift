//
//  TagsLocalStorageImplementer.swift
//  TagsFilter
//
//  Created by Mohamed Ramadan on 08/08/2021.
//

import Foundation

class TagsLocalStorageImplementer: TagsLocalStorage {
    func getTags() -> [Tag] {
        // retrieve items here from User defaults
        guard let decodedTags = UserDefaults.standard.retrieve(object: [Tag].self, fromKey: "tags") else {
            return []
        }
        return decodedTags
    }
    
    func saveTags(tags: [Tag]) {
        // save tags here using User defaults
        UserDefaults.standard.save(customObject: tags, inKey: "tags")
    }
} 
