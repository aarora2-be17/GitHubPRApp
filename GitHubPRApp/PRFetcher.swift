//
//  PRFetcher.swift
//  GitHubPRApp
//
//  Created by Arora, Abhishek on 20/02/22.
//

import Foundation
import SwiftUI
import Alamofire

class PRFetcher :ObservableObject {
    
    @Published var pullRequests = [PR]()
    
    init() {
        fetch()
    }
    
    func fetch() {
        // Sample URL to fetch pull requests
        AF.request("https://api.github.com/repos/freeCodeCamp/freeCodeCamp/pulls?state=closed").responseData { response in
                do{
                    let  prs = try JSONDecoder().decode([PR].self, from: response.data!)
                    self.pullRequests = prs
                }catch let error {
                    print(error)
                }
        }
    }
}
