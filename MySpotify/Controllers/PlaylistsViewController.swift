//
//  PlaylistsViewController.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

class PlaylistsViewController: UITableViewController {
    
    static let showTracksSegue = "ShowTracks"
    
    var source: PlaylistsSource = PlaylistsSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userName = UserSession.session.user?.id {
            title = "\(userName)' playlists"
        } else {
            title = "Playlists"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditing))

        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action:  #selector(refresh), for: .valueChanged)
        
        refresh()
        
    }
    
    func refresh() {
        
        refreshControl?.beginRefreshing()
        
        source.refresh() { error in
            if let error = error {
                
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                    self.presentErrorController(error: error, retryHandler: self.refresh)
                }
                
            } else {
                
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
                
            }
        }
        
    }
    
    func toggleEditing() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.rightBarButtonItem?.title = tableView.isEditing ? "Save" : "Edit"
    }
    
}

//MARK: - UITableViewDataSource

extension PlaylistsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PlaylistTableViewCell", for: indexPath)
    }
    
}

//MARK: - UITableViewDelegate

extension PlaylistsViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let playlist = source.items[indexPath.row]
        (cell as? PlaylistTableViewCell)?.configureWith(playlist: playlist)
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        source.moveItem(fromSourceIndex: sourceIndexPath.row, toTargetIndex: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return proposedDestinationIndexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let playlist = source.items[indexPath.row]
        
        let tracksSource = SPTTracksSource(playlistID: playlist.id)
        let tracksViewController = TracksViewController(source: tracksSource)
        
        tracksViewController.title = playlist.title
        
        navigationController?.pushViewController(tracksViewController, animated: true)
    }
    
}
