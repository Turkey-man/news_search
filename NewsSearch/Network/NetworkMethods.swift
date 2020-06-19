//
//  NetworkMethods.swift
//  NewsSearch
//
//  Created by ****** ****** on 17.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Alamofire

class NetworkMethods {
    
    let baseUrl = "https://newsapi.org/v2/"
    let topHeadlines = "top-headlines?country=us"
    let apiKey = "6e8a6bfe4e7c4751866626c86865b405"
    let formatter = DateFormatter()
    
    func getNews(completion: @escaping (Articles) -> Void) {
        let completeUrl = URL(string: "\(baseUrl)\(topHeadlines)&apiKey=\(apiKey)")
        AF.request(completeUrl!).responseJSON { response in
            switch response.response?.statusCode {
            case 200, 201:
                let decoder = JSONDecoder()
                guard let data = response.data else { return }
                do {
                    let myResponse = try decoder.decode(Articles.self, from: data)
                    completion(myResponse)
                }
                catch let requestError {
                    print(requestError)
                }
            default:
                print("Error")
                }
        }
    }
    
    func findNews(searchRequest: String, completion: @escaping (Articles) -> Void) {
        let lasMonthDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())//Date()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: lasMonthDate!)
        let completeUrl = URL(string: "\(baseUrl)everything?q=\(searchRequest)&from=\(dateString)&sortBy=publishedAt&apiKey=\(apiKey)")
        guard let fullUrl = completeUrl else {return}
        AF.request(fullUrl).responseJSON { response in
            switch response.response?.statusCode {
            case 200, 201:
                let decoder = JSONDecoder()
                guard let data = response.data else { return }
                do {
                    let myResponse = try decoder.decode(Articles.self, from: data)
                    completion(myResponse)
                }
                catch let requestError {
                    print(requestError)
                }
            default:
                print("Error")
                }
        }
    }
    
    func checkConnection() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
