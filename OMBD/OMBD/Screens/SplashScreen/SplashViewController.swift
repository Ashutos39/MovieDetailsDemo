//
//  SplashViewController.swift
//  OMBD
//
//  Created by Ashutos Sahoo on 22/08/22.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var animationView: UIView!
    
    private let splashAnimationView = LottieHelper.splashScreenAnimation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.moveToHomeView()
        }
    }
    
    func setUpUI() {
        splashAnimationView.frame = animationView.bounds
        animationView.addSubview(splashAnimationView)
        splashAnimationView.play()
    }
    
    func moveToHomeView() {
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}
