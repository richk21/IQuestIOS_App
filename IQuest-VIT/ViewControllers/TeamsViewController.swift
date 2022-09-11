//
//  TeamsViewController.swift
//  IQuest-VIT
//
//  Created by Richa on 23/01/22.
//

import UIKit
import SwiftUI

class TeamsViewController: UIViewController {

    public static var aboutDict = [aboutCard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller = UIHostingController(rootView: aboutUsPage())
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(controller)
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            controller.view.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            controller.view.heightAnchor.constraint(equalToConstant: view.frame.size.height+view.frame.size.height/10),
            controller.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
