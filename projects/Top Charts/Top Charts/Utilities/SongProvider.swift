//
//  SongData.swift
//  Top Charts
//
//  Created by Sergen Gonenc on 1/27/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

fileprivate class SongProvider {
    
    // MARK: - Properties
    static let shared = SongProvider()
    private let baseUrl = "https://rss.itunes.apple.com/api/v1"
    
    // MARK: - Life Cycle
    private init() { }
    
    // MARK: Functions
    func loadTopCharts() -> [Song] {
        let urlString = "us/apple-music/top-songs/all/50/non-explicit.json"
        
        if let data = getData(from: urlString) {
            if let songs = jsonDictionary(from: data)?["results"] {
                do {
                    let data = try JSONSerialization.data(withJSONObject: songs, options: .fragmentsAllowed)
                    let decoder = JSONDecoder()
                    
                    return try decoder.decode([Song].self, from: data)
                }catch {
                    debugPrint(error.localizedDescription)
                    return []
                }
            }
        }
        
        return []
    }
    
    private func getData(from urlString: String) -> Data? {
        guard let url = URL(string: baseUrl + "/" + urlString) else {
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
            return (dictionary as? [String : Any])?["feed"] as? [String : Any]
        }catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}

// Song data to be used in this app.
let SongData = SongProvider.shared.loadTopCharts()
