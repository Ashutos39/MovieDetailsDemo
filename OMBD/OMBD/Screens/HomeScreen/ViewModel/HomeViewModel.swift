//
//  HomeViewModel.swift
//  OMBD
//
//  Created by Ashutos Sahoo on 22/08/22.
//

import Foundation

protocol HomeViewModelProtocol {
    func updateUI()
    func updateError(errorMessage: String)
}

final class HomeViewModel {
    private let networkManager: NetworkManager = NetworkManager()
    private lazy var homeApiWorker = HomeApiWorker(withNetworkManager: networkManager)
    var delegate: HomeViewModelProtocol?
    var homeModel: HomeModel?
    var count: Int = 1
    
    func getHomeData(pageNumber: Int) {
        homeApiWorker.getData(perPage: pageNumber) { [weak self] (result: Result<HomeModel, GithubDemoError>) in
            switch result {
            case .success(let response):
                if let homeModel = self?.homeModel {
                    self?.homeModel?.search?.append(contentsOf: response.search ?? [])
                    self?.homeModel?.totalResults = response.totalResults
                } else {
                    self?.homeModel = response
                }
                self?.delegate?.updateUI()
            case .failure(let error):
                self?.delegate?.updateError(errorMessage: error.localizedDescription)
            }
        }
        
    }
}
