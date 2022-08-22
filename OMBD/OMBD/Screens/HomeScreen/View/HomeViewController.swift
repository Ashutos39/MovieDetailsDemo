//
//  HomeViewController.swift
//  OMBD
//
//  Created by Ashutos Sahoo on 22/08/22.
//

import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet weak var homeTableView: UITableView!
    
    private let homeVM = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        homeVM.getHomeData(pageNumber: homeVM.count)
        homeVM.delegate = self
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeVM.homeModel?.search?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseIdentifier, for: indexPath) as! HomeTableViewCell
        cell.setUpUI(userModel: homeVM.homeModel?.search?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !(homeVM.homeModel?.search?.isEmpty ?? true) {
            if indexPath.row == (homeVM.homeModel?.search?.count ?? 0) - 3, homeVM.count*10 < Int(homeVM.homeModel?.totalResults ?? "0") ?? 0 {
                homeVM.count += 1
                homeVM.getHomeData(pageNumber: homeVM.count)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetails = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        movieDetails.initiliseData(movieData: homeVM.homeModel?.search?[indexPath.row])
        movieDetails.modalPresentationStyle = .overCurrentContext
        present(movieDetails, animated: true)
    }
}

extension HomeViewController: HomeViewModelProtocol, HelperProtocol {
    func updateUI() {
        mainThread {
            self.homeTableView.reloadData()
        }
    }
    
    func updateError(errorMessage: String) {
        showAlert(withTitle: "Error!!!", withMessage: errorMessage)
    }
}

private extension HomeViewController {
    func registerCell() {
        homeTableView.registerCell(HomeTableViewCell.self)
    }
}
