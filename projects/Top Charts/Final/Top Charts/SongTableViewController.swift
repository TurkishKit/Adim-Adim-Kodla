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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as! SongTableViewCell
        
        cell.albumCoverImageView.setImage(from: song.artworkUrl100)
        cell.nameLabel.text = song.name
        cell.artistNameLabel.text = song.artistName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSongUrl = SongData[indexPath.row].url
        
        tableView.deselectRow(at: indexPath, animated: true)
        UIApplication.shared.open(selectedSongUrl)
    }
}
