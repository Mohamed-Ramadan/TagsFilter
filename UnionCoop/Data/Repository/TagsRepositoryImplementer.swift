//
//  TagsRepositoryImplementer.swift
//  UnionCoop
//
//  Created by Mohamed Ramadan on 08/08/2021.
//

import Foundation

class TagsRepositoryImplementer: TagsRepository {
    var tagsLocalStorage: TagsLocalStorage
    var networkService: NetworkService
    
    init(tagsLocalStorage: TagsLocalStorage, networkService: NetworkService) {
        self.tagsLocalStorage = tagsLocalStorage
        self.networkService = networkService
    }
    
    func getTags(min: Int, tagged: String, fromDate: Int64, toDate: Int64, order: String, sort: String, site: String, completion: @escaping (DataCallbackCompletion) -> Void) {
        
        //TODO: - fetch remote data
        self.networkService.getRemoteTags(min: min, tagged: tagged, fromDate: fromDate, toDate: toDate, order: order, sort: sort, site: site) { [weak self] (items, error) in
            
            guard error == nil else {
                
                // fetch local data
                guard let storedItems = self?.tagsLocalStorage.getTags() else {
                    completion((nil, error))
                    return
                }
                  
                
                // return with existing error
                completion((storedItems, error))
                return
            }
            
            
            // cache fetched data
            if let items = items, !items.isEmpty {
                self?.tagsLocalStorage.saveTags(tags: items)
            }
            
            completion((items, nil))
        }
    }
}
