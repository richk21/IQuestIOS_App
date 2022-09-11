//
//  HamburgerViewController.swift
//  IQuest-VIT
//
//  Created by Richa on 26/01/22.
//

import UIKit

class HamburgerViewController: UIViewController {
    
    let Storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    @IBOutlet weak var AboutUsButton: UIButton!
    
    @IBOutlet weak var contactUsButton: UIButton!
    @IBOutlet var MainBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menu"
    }
    
    
    @IBAction func AboutUsPressed(_ sender: Any) {
        let teamsVC = Storyboard.instantiateViewController(withIdentifier: "TeamsViewController") as! TeamsViewController
        navigationController!.pushViewController(teamsVC, animated: true)
        
    }
    
    
    @IBAction func contactUsPressed(_ sender: Any) {
        let conVC = Storyboard.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
        navigationController!.pushViewController(conVC, animated: true)
    }
    
    
}
