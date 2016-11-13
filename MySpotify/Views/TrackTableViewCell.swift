//
//  TrackTableViewCell.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

class TrackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    
    
    func configureWith(track: Track) {
        titleLabel.text = track.title
        artistLabel.text = ""
        bpmLabel.text = ""
//        artistLabel.text = track.artists.map({ $0.name }).joined(separator: ", ")
        
//        if let tempo = track.tempo {
//            bpmLabel.text = String(format: "%.0fbpm", arguments: [tempo])
//        } else {
//            bpmLabel.text = ""
//        }
    }
    
}
