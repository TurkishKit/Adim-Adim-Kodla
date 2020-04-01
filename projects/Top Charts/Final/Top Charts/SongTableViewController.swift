//
//  ViewController.swift
//  Top Charts
//
//  Created by Sergen Gonenc on 1/27/20.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

class SongTableViewController: UITableViewController {
    
    // MARK: - Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SongData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let song = SongData[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as? SongTableViewCell {
            
            cell.nameLabel.text = song.name
            cell.artistLabel.text = song.artistName
            // burada her eriştiğimizde resim yeniden indiriliyor, aslında resim song struct'ının bir parçası olmalı ve ilk decode edildiğinde indirilmeli ve bir değişkende saklanmalı, ama nasıl?
            cell.albumImageView.image = UIImage(url: song.artworkUrl100)
            cell.albumImageView.layer.cornerRadius = 5.0
            return cell
        }
        
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let songUrl = URL(string: SongData[indexPath.row].url) {
            UIApplication.shared.open(songUrl)
        }
    }
    
}
