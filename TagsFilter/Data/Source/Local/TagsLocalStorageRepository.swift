//
//  TagsLocalStorageRepository.swift
//  TagsFilter
//
//  Created by Mohamed Ramadan on 08/08/2021.
//

import Foundation

protocol TagsLocalStorage {
    func getTags() -> [Tag]
    func saveTags(tags: [Tag])
}
