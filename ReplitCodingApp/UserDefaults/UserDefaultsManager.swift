//
//  UserDefaultsManager.swift
//  ReplitCodingApp
//
//  Created by user on 11/23/21.
//

import Foundation

struct Playground {
    let id: String
    let title: String
    let code: String
}

class UserDefaultsManager {
    static let defaults = UserDefaults.standard
    
    static func addPlayground(playground: Playground) {
        let dict = [
            "title": playground.title,
            "code": playground.code
        ]
        defaults.setValue(dict, forKey: playground.id)
        
        var playgroundIds = defaults.object(forKey: "ids") as? [String] ?? []
        playgroundIds.append(playground.id)
        
        defaults.setValue(playgroundIds, forKey: "ids")
    }
    
    static func deletePlayground(id: String) {
        defaults.removeObject(forKey: id)
    }
    
    static func updatePlaygroundCode(playground: Playground, newCode: String) {
        let newPlaygroundDict = [
            "title": playground.title,
            "code": newCode
        ]
        defaults.setValue(newPlaygroundDict, forKey: playground.id)
    }
    
    static func getPlaygrounds() -> [Playground] {
        let ids = defaults.object(forKey: "ids") as? [String] ?? []
        var playgrounds = [Playground]()
        for id in ids {
            guard let dict = defaults.object(forKey: id) as? [String: String],
                  let title = dict["title"],
                    let code = dict["code"] else {
                continue
            }
            
            let playground = Playground(id: id, title: title, code: code)
            playgrounds.append(playground)
        }
        
        return playgrounds
    }
}
