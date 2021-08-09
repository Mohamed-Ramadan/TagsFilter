//
//  NetworkService.swift
//  UnionCoop
//
//  Created by Mohamed Ramadan on 08/08/2021.
//

import Foundation

class NetworkService {
    
    static let serverURl = "https://api.stackexchange.com/2.2/questions/no-answers?"
    static let username = "stackexchange"
    static let password = "admin@123456"
    static let contentType = "application/json"
    static let lang = "en"
    static let deviceType = "IOS"
    
    static func getRemoteTags(min: Int, tagged: String, fromDate: TimeInterval, toDate: TimeInterval, order: String, sort: String, site: String, completion:  @escaping (DataCallbackCompletion) -> Void) {
        
        let urlString = serverURl + "min=\(min)&tagged=\(tagged)&fromdate=\(fromDate)&todate=\(toDate)&order=asc&sort=votes&site=stackoverflow"
        guard let url = URL(string: urlString) else {
            print("Wrong URL!: \(urlString)")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("stackexchange", forHTTPHeaderField: "Username")
        urlRequest.addValue("admin@123456", forHTTPHeaderField: "Password")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("en", forHTTPHeaderField: "Lang")
        urlRequest.addValue("IOS", forHTTPHeaderField: "DeviceType")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion((nil, error?.localizedDescription))
                return
            }
            
            guard let data = data else {
                completion((nil, "Data not valid or empty"))
                return
            }
            
            do {
                // parse json data to model items
                let response = try JSONDecoder().decode(TagsResponse.self, from: data)
                completion((response.tags, nil))
                
            } catch {
                print(error.localizedDescription)
                completion((nil, error.localizedDescription))
            }
            
        }
        
        task.resume()
    }
}
