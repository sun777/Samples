//
//  Loader.swift
//  TableViewExample
//
//  Created by Shaik, Suneelahammad (Cognizant) on 14/04/22.
//

import Foundation
import UIKit

public class Loader {
    
    public static let shared = Loader()
    var indicator = UIActivityIndicatorView()
    var imageView = UIImageView()
    
    private init() {
        imageView.frame = UIScreen.main.bounds
        imageView.backgroundColor = .gray
        imageView.isUserInteractionEnabled = true
        imageView.alpha = 0.5
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.color = .red
        indicator.center = imageView.center
        indicator.startAnimating()
    }
    
    func show() {
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let window = windowScene.windows.first
                window?.addSubview(self.indicator)
            }
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.indicator.removeFromSuperview()
        }
    }
}
