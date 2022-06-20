//
//  FavoriteUserModels.swift
//  GithubUser
//

import UIKit

enum FavoriteUser {
    // MARK: Use cases
    
    enum LoadFavoriteUser {
        struct Request {
        }
        
        struct Response {
            let userList: [User]
        }
        
        struct ViewModel {
            struct Section {
                let sectionName: String
                var userList: [User]
            }
            
            var sections: [Section]
            
            func sectionCount() -> Int {
                sections.count
            }
            func sectionName(section: Int) -> String {
                guard sections.count > section else { return "?"}
                
                return sections[section].sectionName
            }
            
            func sectionUserCount(section: Int) -> Int {
                guard sections.count > section else { return 0}
                
                return sections[section].userList.count
            }
            
            func user(indexPath: IndexPath) -> User? {
                guard sections.count > indexPath.section else { return nil }
                guard sections[indexPath.section].userList.count > indexPath.row else { return nil }
                
                return sections[indexPath.section].userList[indexPath.row]
            }
        }
    }
    
    enum UnfavoriteUser {
        struct Request {
            let user: User
        }
        
        struct Response {
            let user: User
        }
        
        struct ViewModel {
            let id: Int
        }
    }
    
    enum SearchUser {
        struct Request {
            let name: String
        }
    }
}
