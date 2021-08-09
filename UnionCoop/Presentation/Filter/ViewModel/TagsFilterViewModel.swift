//
//  TagsFilterViewModel.swift
//  UnionCoop
//
//  Created by Mohamed Ramadan on 08/08/2021.
//

import Foundation

protocol TagsFilterViewModelInput {
    func didChangeMin(min: Int)
    func didChangeTagged(tagged: String)
    func didTapFilterButton()
}

class TagsFilterViewModel {
    private(set) var min: Int
    private(set) var tagged: String
    
    var error: (String) -> Void = {_ in}
    var applyFilter:()-> Void = {}
    
    init(min: Int, tagged: String) {
        self.min = min
        self.tagged = tagged
    }
}

extension TagsFilterViewModel: TagsFilterViewModelInput {
    func didChangeMin(min: Int) {
        self.min = min
    }
    
    func didChangeTagged(tagged: String) {
        self.tagged = tagged
    }
    
    func didTapFilterButton() {
        guard (min >= 1 && min <= 5) else {
            self.error("Min value should be in between 1 and 5")
            return
        }
        
        self.applyFilter()
    }
}
