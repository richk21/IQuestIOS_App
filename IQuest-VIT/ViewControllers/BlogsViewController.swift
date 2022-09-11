//
//  BlogsViewController.swift
//  IQuest-VIT
//
//  Created by Richa on 23/01/22.
//

/*import UIKit

class BlogsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Blogs"
    }

}*/

import UIKit
import Firebase
import SwiftUI

class BlogsViewController: UIViewController {
    
    public static var gridItems = [GridItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n\nBLOGS: \(BlogsViewController.gridItems)\n\n")
        let controller = UIHostingController(rootView: blogsPage())
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
