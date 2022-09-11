//
//  RegisterViewController.swift
//  IQuest-VIT
//
//  Created by Richa on 12/06/22.
//

import UIKit
import Firebase
import SwiftUI
import FirebaseDatabase

class RegisterViewController: UIViewController{

    
    public static var upcomingEventDict = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = RegisterViewController.upcomingEventDict[0]
        
        let controller = UIHostingController(rootView: parallaxEffect())
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(controller)
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            controller.view.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            controller.view.heightAnchor.constraint(equalToConstant: view.frame.size.height+10),
            controller.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
    }

}
