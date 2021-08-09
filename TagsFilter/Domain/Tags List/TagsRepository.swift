//
//  TagsRepository.swift
//  TagsFilter
//
//  Created by Mohamed Ramadan on 08/08/2021.
//

import Foundation

typealias DataCallbackCompletion = (item: [Tag]?, error: String?)

protocol TagsRepository {
    func getTags(min: Int, tagged: String, fromDate: Int64, toDate: Int64, order: String, sort: String, site: String, completion: @escaping (DataCallbackCompletion) -> Void)
}
