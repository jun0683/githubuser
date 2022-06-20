//
//  FavoriteUserPresenter.swift
//  GithubUser
//

import UIKit

protocol FavoriteUserPresentationLogic {
    func presentUserList(response: FavoriteUser.LoadFavoriteUser.Response)
    func presentUnfavoriteUser(response: FavoriteUser.UnfavoriteUser.Response)
}

protocol FavoriteUserDataSource {
    var viewModel: FavoriteUser.LoadFavoriteUser.ViewModel? { get set }
}

final class FavoriteUserPresenter: FavoriteUserPresentationLogic, FavoriteUserDataSource {
    var viewModel: FavoriteUser.LoadFavoriteUser.ViewModel?
    weak var viewController: FavoriteUserDisplayLogic?
    
    // MARK: Do something
    
    func presentUserList(response: FavoriteUser.LoadFavoriteUser.Response) {
        let sections = groupingSection(response.userList)
        let viewModel = FavoriteUser.LoadFavoriteUser.ViewModel.init(sections: sections)
        
        self.viewModel = viewModel
        
        viewController?.displayUserList(viewModel: viewModel)
    }
    
    func presentUnfavoriteUser(response: FavoriteUser.UnfavoriteUser.Response) {
        guard var viewModel = viewModel else { return }
        
        if let sectionIndex = viewModel.sections.firstIndex(where: {
            $0.sectionName.uppercased() == response.user.name.first!.uppercased() }) {
            var section = viewModel.sections[sectionIndex]
            
            section.userList = section.userList.filter({ $0.id != response.user.id })
            
            if section.userList.isEmpty {
                viewModel.sections.remove(at: sectionIndex)
            } else {
                viewModel.sections[sectionIndex] = section
            }
        }
        
        self.viewModel = viewModel
        
        viewController?.displayUserList(viewModel: viewModel)
        viewController?.displayUpdateUnfavoriteUser(viewModel: .init(id: response.user.id))
    }
    
    private func groupingSection(_ userList: [User]) -> [FavoriteUser.LoadFavoriteUser.ViewModel.Section] {
        let sortedUserList = userList.sorted(by: { $0.name.localizedCompare($1.name) == .orderedAscending })
        
        return Dictionary(grouping: sortedUserList, by: { user in
            user.name.uppercased().first!
        }).map { (key: String.Element, value: [User]) in
            FavoriteUser.LoadFavoriteUser.ViewModel.Section.init(sectionName: String(key), userList: value)
        }.sorted(by: {
            $0.sectionName.localizedCompare($1.sectionName) == .orderedAscending
        })
    }
}
