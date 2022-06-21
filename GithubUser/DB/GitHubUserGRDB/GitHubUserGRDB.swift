//
//  GitHubUserGRDB.swift
//  GithubUser
//

import Foundation
import GRDB

final class GitHubUserGRDB: DBProtocol {
    static let shared = GitHubUserGRDB()
    
    private var dbQueue: DatabaseQueue?
    
    struct UserORM: Codable, FetchableRecord, PersistableRecord, Identifiable {
        var id: Int
        var name: String
        var profileUrl: String
        var favorite: Bool
        
        func converter() -> User {
            User.init(name: name, profileUrl: profileUrl, favorite: favorite, id: id)
        }
    }
    
    init() {
        do {
            let databaseURL = try FileManager.default
                        .url(for: .applicationDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                        .appendingPathComponent("db.sqlite")
            
            dbQueue = try DatabaseQueue(path: databaseURL.path)
            
            try dbQueue?.write { db in
                try db.create(table: "userORM", options: [.ifNotExists]) { t in
                    t.autoIncrementedPrimaryKey("id")
                    t.column("name", .text).notNull()
                    t.column("profileUrl", .text).notNull()
                    t.column("favorite", .boolean).notNull()
                }
            }
        } catch let e {
            print(#function, #line, e)
        }
    }
    
    func setFavoriteID(user: User) {
        do {
            if var setedUser = try dbQueue?.read({ db in
                try UserORM.filter(id: user.id).fetchOne(db)
            }) {
                try dbQueue?.write { db in
                    setedUser.favorite = !setedUser.favorite
                    
                    try setedUser.updateChanges(db, from: setedUser)
                }
            } else {
                var user = user
                user.favorite = true
                
                try dbQueue?.write { db in
                    try UserORM(id: user.id, name: user.name, profileUrl: user.profileUrl, favorite: user.favorite).insert(db)
                }
            }
        } catch let e {
            print(#function, #line, e)
        }
    }
    
    func getFavoriteID(user: User) -> Bool {
        do {
            if let getUser = try dbQueue?.read({ db in
                try UserORM.filter(id: user.id).fetchOne(db)
            }) {
                return getUser.favorite
            } else {
                try dbQueue?.write { db in
                    try UserORM(id: user.id, name: user.name, profileUrl: user.profileUrl, favorite: user.favorite).insert(db)
                }
                return false
            }
        } catch let e {
            print(#function, #line, e)
        }
        return false
    }
    
    func unfavoriteUser(user: User) {
        do {
            _ = try dbQueue?.write { db in
                try UserORM.deleteOne(db, key: ["id" : user.id])
            }
        } catch let e {
            print(#function, #line, e)
        }
    }
    
    func getFavoriteUserList() -> [User] {
        do {
            if let userlist = try dbQueue?.read({ db in
                try UserORM.fetchAll(db)
            }) {
                return userlist.map({ $0.converter() })
            }
        } catch let e {
            print(#function, #line, e)
        }
        
        return []
    }
}
