//
//  NetworkService.swift
//  UnionCoop
//
//  Created by Mohamed Ramadan on 08/08/2021.
//

import Foundation

protocol NetworkService {
    func getRemoteTags(min: Int, tagged: String, fromDate: Int64, toDate: Int64, order: String, sort: String, site: String, completion:  @escaping (DataCallbackCompletion) -> Void)
}

class URLSessionNetworkService: NetworkService {
     
    func getRemoteTags(min: Int, tagged: String, fromDate: Int64, toDate: Int64, order: String, sort: String, site: String, completion:  @escaping (DataCallbackCompletion) -> Void) {
        
        let urlString = Constants.serverURl + "min=\(min)&tagged=\(tagged)&fromdate=\(Int(fromDate))&todate=\(Int(toDate))&order=asc&sort=votes&site=stackoverflow"
        guard let urlEncodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: urlEncodedString) else {
            print("Wrong URL!: \(urlString)")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.addValue(Constants.username, forHTTPHeaderField: "Username")
        urlRequest.addValue(Constants.password, forHTTPHeaderField: "Password")
        urlRequest.addValue(Constants.contentType, forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(Constants.lang, forHTTPHeaderField: "Lang")
        urlRequest.addValue(Constants.deviceType, forHTTPHeaderField: "DeviceType")
        
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
