//
//  HomeViewController.swift
//  IQuest-VIT
//
//  Created by Richa on 22/01/22.
//

import UIKit
import Foundation
import Firebase
import SwiftUI
import FirebaseDatabase

class HomeViewController: UIViewController{
    
    public static var blogsDict = [blogsCard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller = UIHostingController(rootView: homePage())
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(controller)
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            controller.view.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            controller.view.heightAnchor.constraint(equalToConstant: view.frame.size.height + 10*view.frame.size.height/896),
            controller.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
