//
//  NewsProvider.swift
//  Haberler
//
//  Created by Ufuk Köşker on 22.02.2020.
//  Copyright © 2020 Ufuk Köşker. All rights reserved.
//

import UIKit

fileprivate class NewsProvider {
    
    // MARK: - Properties
    static let shared = NewsProvider()
    
    
    // MARK: - Life Cycle
    private init() { }
    
    // MARK: Functions
    
    func loadNews() -> [News] {
        let urlString = "https://api.rss2json.com/v1/api.json?rss_url=https://inceleme.co/feed"
        
        if let data = getData(from: urlString) {
            if let news = jsonDictionary(from: data)?["items"] {
                do {
                    let data = try JSONSerialization.data(withJSONObject: news, options: .fragmentsAllowed)
                    let decoder = JSONDecoder()
                    
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                    
                    let newsItems = try decoder.decode([News].self, from: data)
                    let newsWithThumbnails = newsItems.filter({ !$0.thumbnail.isEmpty })
                    
                    return newsWithThumbnails.map { (news) -> News in
                        var myNews = news
                        myNews.categories = Array(myNews.categories.prefix(3)).map({ $0.capitalized })
                        
                        return myNews
                    }
                }catch {
                    debugPrint(error)
                    return []
                }
            }
        }
        return []
    }
    
    private func getData(from urlString: String) -> Data? {
        guard let url = URL(string: urlString) else {
            fatalError("Couldn't load URL from provided string.")
        }
        
        do {
            return try Data(contentsOf: url)
        } catch {
            debugPrint("Couldn't load data from URL:\n\(error)")
            return nil
        }
    }
    
    private func jsonDictionary(from data: Data) -> [String : Any]? {
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return (dictionary as? [String : Any])
        }catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}

// News data to be used in this app.
let NewsData = NewsProvider.shared.loadNews()
