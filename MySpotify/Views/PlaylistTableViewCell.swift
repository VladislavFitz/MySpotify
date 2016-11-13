//
//  PlaylistTableViewCell.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

class PlaylistTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    func configureWith(playlist: SPTPlaylist) {
        titleLabel.text = playlist.title
        countLabel.text = "\(playlist.tracksRepresentation.count) tracks"
    }
    
}
