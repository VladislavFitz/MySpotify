//
//  Storage.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

class Storage: NSObject {
    
    static let sharedInstance = Storage()
    
    var playlists: [SPTPlaylist] = []
    
    private override init() {}
    
    func movePlaylist(fromSourceIndex sourceIndex: Int, toTargetIndex targetIndex: Int) {
        let playlistToMove = playlists.remove(at: sourceIndex)
        var updatedPlaylists = self.playlists
        updatedPlaylists.insert(playlistToMove, at: targetIndex)
        store(playlists: updatedPlaylists)
    }
    
    func tracks(forPlaylistWithID playlistID: String) -> [SPTTrack] {
        
        guard let playlist = playlists.filter({ $0.id == playlistID }).first else {
            return []
        }
        
        switch playlist.tracksRepresentation {
        case .tracks(let tracks):
            return tracks
            
        case .url:
            return []
        }
        
    }
    
    func refreshPlaylists(completion: @escaping (Error?) -> Void) {
        guard let user = UserSession.session.user else { return }
        
        PlaylistsRequest(user: user).perform() { result in
            switch result {
            case .failure(let error):
                completion(error)
                
            case .success(let playlistsWrapper):
                let playlists = playlistsWrapper.items
                self.store(playlists: playlists)
                completion(.none)
            }
        }
    }
    
    func refreshTracks(forPlaylistWithID playlistID: String, completion: @escaping (Error?) -> Void) {
        
        guard let user = UserSession.session.user else { return }
        
        SPTTracksRequest(userID: user.id, playlistID: playlistID).perform() { result in
            
            switch result {
            case .failure(let error):
                completion(error)
                
            case .success(let tracksWrapper):
                let tracks = tracksWrapper.items
                
                AudioFeaturesRequest(trackIDs: tracks.map({ $0.id })).perform() { result in
                    switch result {
                    case .failure(let error):
                        completion(error)
                        
                    case .success(let featuresWrapper):
                        let tracksWithFeatures = zip(tracks, featuresWrapper.audioFeatures).map { (track, features) -> SPTTrack in
                            var mutatedTrack = track
                            mutatedTrack.tempo = features.tempo
                            return mutatedTrack
                        }
                        
                        self.store(tracks: tracksWithFeatures, forPlaylistWithID: playlistID)
                        completion(.none)
                    }
                }
                
            }
            
            
        }
        
    }
    
    private func store(playlists: [SPTPlaylist]) {
        var updatedUser = UserSession.session.user
        updatedUser?.playlists = playlists
        UserSession.session.user = updatedUser
    }
    
    private func store(tracks: [SPTTrack], forPlaylistWithID playlistID: String) {
        
        if let playlistIndex = self.playlists.index(where: { $0.id == playlistID }) {
            var updatedPlaylist = self.playlists.remove(at: playlistIndex)
            updatedPlaylist.tracksRepresentation = .tracks(tracks)
            var updatedPlaylists = self.playlists
            updatedPlaylists.insert(updatedPlaylist, at: playlistIndex)
            store(playlists: updatedPlaylists)
        }
        
    }
    

    
}
