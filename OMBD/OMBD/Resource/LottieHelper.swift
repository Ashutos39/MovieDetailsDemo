//
//  LottieHelper.swift
//  OMBD
//
//  Created by Ashutos Sahoo on 22/08/22.
//

import Foundation
import Lottie

final class LottieHelper {
    static func splashScreenAnimation() -> AnimationView {
        let animationView = AnimationView(name: "splash_animation")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
        return animationView
    }
}

