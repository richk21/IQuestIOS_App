//
//  ContactViewController.swift
//  IQuest-VIT
//
//  Created by Richa on 23/01/22.
//

import UIKit
import MessageUI
import SafariServices
import SwiftUI


class ContactViewController: UIViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contact Us"
        
        let controller = UIHostingController(rootView: ContactUsPage())
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
