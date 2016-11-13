//
//  TracksViewController.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import PureLayout

class TracksViewController<TracksSource: RefreshableTracksSource>: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()
    var source: TracksSource!
    
    init(source: TracksSource) {
        self.source = source
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.source = nil
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureRefreshControl()
        refresh()
        
    }
    
    func refresh() {
        
        refreshControl.beginRefreshing()
        
        source.refresh() { error in
            if let error = error {
                
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.presentErrorController(error: error, retryHandler: self.refresh)
                }
                
            } else {
                
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                }
                
            }
        }
        
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.autoPin(toTopLayoutGuideOf: self, withInset: -64)
        tableView.autoPin(toBottomLayoutGuideOf: self, withInset: -48)
        tableView.autoPinEdge(.leading, to: .leading, of: view)
        tableView.autoPinEdge(.trailing, to: .trailing, of: view)
        tableView.register(TrackTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.addSubview(refreshControl)
    }
    
    private func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(forIndexPath: indexPath) as TrackTableViewCell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let trackCell = cell as? TrackTableViewCell {
            let track = source.items[indexPath.row]
            trackCell.configureWith(track: track)
        }
    }
    
}
