//
//  GithubUserTests.swift
//  GithubUserTests
//
//  Created by hongjunkim on 2022/06/17.
//

import XCTest
@testable import GithubUser

class GithubUserTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_검색화면에서_응답에러() throws {
        // given
        let workerMock = GithubUserSearchWorkerMock(db: GitHubUserDB.shared)
        let interactor = GitHubUserSearchInteractor(worker: workerMock)
        let presenter = GitHubUserSearchPresenter()
        let viewControllerMock = GitHubUserSearchDisplayMock()
        interactor.presenter = presenter
        presenter.viewController = viewControllerMock

        // when
        workerMock.searchResult = .failure(NSError(domain: "", code: -1))
        interactor.searchUser(request: .init(name: "test"))

        // then
        XCTAssertEqual((viewControllerMock.displayError as? NSError)?.code, -1)
    }
    
    func test_검색화면에서_응답성공() throws {
        // given
        let workerMock = GithubUserSearchWorkerMock(db: GitHubUserDB.shared)
        let interactor = GitHubUserSearchInteractor(worker: workerMock)
        let presenter = GitHubUserSearchPresenter()
        let viewControllerMock = GitHubUserSearchDisplayMock()
        interactor.presenter = presenter
        presenter.viewController = viewControllerMock

        // when
        workerMock.searchResult = .success(.init(totalCount: 2,
                                                 incompleteResults: true,
                                                 items: [.init(login: "test1", id: 0, avatarURL: "https://dramancompany.com"),
                                                         .init(login: "test2", id: 1, avatarURL: "https://dramancompany.com")]))
        interactor.searchUser(request: .init(name: "test"))

        // then
        XCTAssertEqual(viewControllerMock.displaySearchUserViewModel?.userList.first?.name, "test1")
        XCTAssertEqual(viewControllerMock.displaySearchUserViewModel?.userList.last?.name, "test2")
    }
    
    func test_검색화면에서_검색후_즐겨찾기() throws {
        // given
        let workerMock = GithubUserSearchWorkerMock(db: GitHubUserDB.shared)
        let interactor = GitHubUserSearchInteractor(worker: workerMock)
        let presenter = GitHubUserSearchPresenter()
        let viewControllerMock = GitHubUserSearchDisplayMock()
        interactor.presenter = presenter
        presenter.viewController = viewControllerMock

        // when
        workerMock.searchResult = .success(.init(totalCount: 2,
                                                 incompleteResults: true,
                                                 items: [.init(login: "test1", id: 0, avatarURL: "https://dramancompany.com"),
                                                         .init(login: "test2", id: 1, avatarURL: "https://dramancompany.com")]))
        interactor.searchUser(request: .init(name: "test"))
        let user = viewControllerMock.displaySearchUserViewModel!.userList.first!
        interactor.favoriteUser(request: .init(user: user))

        // then
        XCTAssertEqual(viewControllerMock.displaySearchUserViewModel?.userList.first?.favorite, true)
        XCTAssertEqual(viewControllerMock.displaySearchUserViewModel?.userList.last?.favorite, false)
    }
}

class GithubUserSearchWorkerMock: GitHubUserSearchWorkerProtocol {
    var db: DBProtocol
    var searchResult: Result<SearchResultModel, Error>?
    
    init(db: DBProtocol) {
        self.db = db
    }
    
    func searchUser(name: String, completion: @escaping (Result<SearchResultModel, Error>) -> Void) {
        if let searchResult = searchResult {
            completion(searchResult)
        }
    }
    
    func setFavoriteID(user: User) {
        db.setFavoriteID(user: user)
    }
    
    func getFavoriteID(user: User) -> Bool {
        db.getFavoriteID(user: user)
    }
    
    func getFavoriteUserList() -> [User] {
        db.getFavoriteUserList()
    }
    
}

class GitHubUserSearchDisplayMock: GitHubUserSearchDisplayLogic {
    var displaySearchUserViewModel: GitHubUserSearch.SearchUser.ViewModel?
    var displayError: Error?
    
    func displaySearchUser(viewModel: GitHubUserSearch.SearchUser.ViewModel) {
        displaySearchUserViewModel = viewModel
    }
    
    func displayUpdateFavoriteUser() {
        
    }
    
    func displayError(error: Error) {
        displayError = error
    }
}
