//
//  MovieDetailsViewController.swift
//  OMBD
//
//  Created by Ashutos Sahoo on 22/08/22.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController {
    
   
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.addCornerRadius(withRadius: 20.0)
        }
    }
    
    @IBOutlet weak var movieImageView: UIImageView! {
        didSet {
            movieImageView.addCornerRadius(withRadius: 10.0)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    private var movieData: Search?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    func initiliseData(movieData: Search?) {
        self.movieData = movieData
    }
    
    func setUpUI() {
        if let movieData = movieData {
            titleLabel.text = movieData.title ?? "" + " at \(movieData.year ?? "")"
            subTitleLabel.text = (movieData.type ?? "") + " imdbId \(movieData.imdbID ?? "")"
            if let imageString = movieData.poster, let url = URL(string: imageString)  {
                movieImageView.kf.setImage(with: url)
            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
