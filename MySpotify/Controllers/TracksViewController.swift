//
//  TracksViewController.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

class TracksViewController<TracksSource: RefreshableTracksSource>: UITableViewController {
    
    var source: TracksSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TrackTableViewCell.self)
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refresh()
        
    }
    
    func refresh() {
        
        self.refreshControl?.beginRefreshing()
        
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
    
    //MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(forIndexPath: indexPath) as TrackTableViewCell
    }
    
    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let trackCell = cell as? TrackTableViewCell {
            let track = source.items[indexPath.row]
            trackCell.configureWith(track: track)
        }
    }
    
}
