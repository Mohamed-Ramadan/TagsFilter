//
//  ListViewModel.swift
//  TagsFilter
//
//  Created by Mohamed Ramadan on 08/08/2021.
//

import Foundation

struct TagItemViewModel {
    let answersCount: String
    let viewsCount: String
    let questionTitle: String
    let username: String
    let reputation: String
}
  
class TagsViewModel {
    private(set) var min: Int = 5
    private(set) var tagged: String = "swift"
    
    /*
     Note: if i used the calculated timestamps, it gives me an empty result
     so, i used the static timestamps provided in the task example
    */
    
    let fromDate: Int64 = 1601617341 //Int64(Calendar.current.date(byAdding: .day, value: -30, to: Date())?.timeIntervalSince1970 ?? 0 * 1000)
    let toDate: Int64 =  1604209341 // Int64(Date().timeIntervalSince1970)
    let order: String = "asc"
    let sort: String = "votes"
    let site: String = "stackoverflow"
     
    var tagsUseCase: TagsUseCase
    
    init(repository: TagsRepository) {
        tagsUseCase = TagsUseCase(repository: repository)
    }
    
    var tags: [Tag] = [] {
        didSet {
            self.tagsCompletionHandler()
        }
    }
    
    var tagsCompletionHandler: ()->() = {}
    var isLoading: (Bool)->() = {_ in}
    var error: (String)->() = {_ in}
    
    func getTags() {
        self.isLoading(true)
        
        self.tagsUseCase.getTagsListUseCase(min: min, tagged: tagged, fromDate: fromDate, toDate: toDate, order: order, sort: sort, site: site) { [weak self] (items, error) in
            
            self?.isLoading(false)
            
            guard error == nil else {
                self?.error(error ?? "Something went wrong, please try again")
                return
            }
            
            guard let items = items else {
                return
            }
            
            self?.tags = items
        }
    }
    
    func setupTagItemViewModel(for index: Int) -> TagItemViewModel {
        let tag = self.tags[index]
        return TagItemViewModel(answersCount: "\(tag.answerCount)", viewsCount: "\(tag.viewCount)", questionTitle: tag.title, username: tag.owner.displayName, reputation: "\(tag.owner.reputation)")
    }
     
    func filterTags(with min: Int, tagged: String) {
        self.min = min
        self.tagged = tagged
         
        self.getTags()
    }
}
