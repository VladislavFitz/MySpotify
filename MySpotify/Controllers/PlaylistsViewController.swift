//
//  PlaylistsViewController.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

class PlaylistsViewController: UITableViewController {
    
    var source: PlaylistsSource = PlaylistsSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowTracks", sender: self)
    }
    
}
