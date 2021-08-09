//
//  TagsUseCase.swift
//  UnionCoop
//
//  Created by Mohamed Ramadan on 08/08/2021.
//

import Foundation

class TagsUseCase {
    var repository: TagsRepository
    
    init(repository: TagsRepository) {
        self.repository = repository
    }
    
    func getTagsListUseCase(min: Int, tagged: String, fromDate: Int64, toDate: Int64, order: String, sort: String, site: String, completion: @escaping (DataCallbackCompletion) -> Void) {
        
        self.repository.getTags(min: min, tagged: tagged, fromDate: fromDate, toDate: toDate, order: order, sort: sort, site: site, completion: completion)
    }
}

