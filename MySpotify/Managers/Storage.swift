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
    
    var playlists: [Playlist] = [] {
        didSet {
            let playlistsDictionaries = playlists.map({ $0.dictionary })
            UserDefaults.standard.set(playlistsDictionaries, forKey: "playlists")
            UserDefaults.standard.synchronize()
        }
    }
    
    private override init() {}
    
    func movePlaylist(fromSourceIndex sourceIndex: Int, toTargetIndex targetIndex: Int) {
        let playlistToMove = playlists.remove(at: sourceIndex)
        playlists.insert(playlistToMove, at: targetIndex)
    }
    
    func tracks(forPlaylistWithID playlistID: String) -> [Track] {
        
        guard let playlist = playlists.filter({ $0.id == playlistID }).first else {
            return []
        }
        
        switch playlist.tracks {
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
                self.playlists = playlistsWrapper.items
                completion(.none)
            }
        }
    }
    
    func refreshTracks(forPlaylistWithID playlistID: String, completion: @escaping (Error?) -> Void) {
        
        guard let user = UserSession.session.user else { return }
        
        TracksRequest(userID: user.id, playlistID: playlistID).perform() { result in
            
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
                        let tracksWithFeatures = zip(tracks, featuresWrapper.audioFeatures).map { (track, features) -> Track in
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
    
    private func store(tracks: [Track], forPlaylistWithID playlistID: String) {
        
        if let playlistIndex = self.playlists.index(where: { $0.id == playlistID }) {
            var updatedPlaylist = self.playlists.remove(at: playlistIndex)
            updatedPlaylist.tracks = .tracks(tracks)
            self.playlists.insert(updatedPlaylist, at: playlistIndex)
        }
        
    }
    

    
}
