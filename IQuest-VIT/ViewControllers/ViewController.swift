import UIKit
import Firebase
import SwiftUI

struct eventCard{
    var title: String
    var image: String
    var youtube: String
    var description: String
}

struct blogsCard{
    var title: String
    var image: String
    var link: String
}
struct blogsPageCard{
    var title: String
    var image: String
    var link: String
}

struct projectCard : Identifiable{
    var id = UUID()
    var title: String
    var description: String
    var image: String
    var link: String
}
struct achieveCard : Identifiable{
    var id = UUID()
    var title: String
    var description: String
    var image: String
}
struct aboutCard : Identifiable{
    var id = UUID()
    var image: String
    var name: String
    var email: String
    var github: String
    var linkedin: String
    var position: String
}

class ViewController: UIViewController {
    
    private let imageView:UIImageView = {
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:264, height:328))
        imageView.image = UIImage(named: "iqLaunchLogo")
        return imageView
    }()
    
    let ref = Database.database().reference()
    public static var AchievDict = Dictionary<Int, Array<String>>()

    
    func readDBForBlogs() {
        if FirebaseApp.app() == nil{
            FirebaseApp.configure()
        }
        let ref = Database.database().reference().child("Blogs")
        var title = ""
        var image = ""
        var link = ""
        var random : CGFloat = 0
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let allChildren = snapshot.children.allObjects as! [DataSnapshot]
            for snap in allChildren {
                if let t = snap.childSnapshot(forPath: "title").value as? String {
                    title = " \(t) "
                }
                if let l = snap.childSnapshot(forPath: "link").value as? String {
                    link = l
                }
                random = CGFloat.random(in: 250 ... 400)
                let i = Int.random(in: 1 ... 11)
                image = "blog\(i)"
                BlogsViewController.gridItems.append(GridItem(height: random, title: title, image: image, link: link))
            }
        })
    }
    
    func readDBForHomeBlogs() {
        let ref = Database.database().reference().child("HomeBlogs")
        var title = ""
        var image = ""
        var link = ""
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let allChildren = snapshot.children.allObjects as! [DataSnapshot]
            for snap in allChildren {
                if let t = snap.childSnapshot(forPath: "title").value as? String {
                    title = " \(t) "
                }
                
                if let img = snap.childSnapshot(forPath: "image").value as? String {
                    image = img
                }
                if let l = snap.childSnapshot(forPath: "link").value as? String {
                    link = l
                }
                HomeViewController.blogsDict.append(blogsCard(title: title, image: image, link: link))
                
            }
        })
    }
    
    func readUpcomingDB(){
        var eventTitle = ""
        var formLink = ""
        var whatsappLink = ""
        var description = ""
        var img = ""
        let ref = Database.database().reference().child("Upcoming")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let allChildren = snapshot.children.allObjects as! [DataSnapshot]
            for snap in allChildren {
                if let whatsapp = snap.childSnapshot(forPath: "whatsapplink").value as? String {
                    whatsappLink = whatsapp
                }
                
                if let title = snap.childSnapshot(forPath: "title").value as? String {
                    eventTitle = title
                }
                
                if let form = snap.childSnapshot(forPath: "formlink").value as? String {
                    formLink = form
                }
                if let image = snap.childSnapshot(forPath: "image").value as? String {
                    img = image
                }
                if let desc = snap.childSnapshot(forPath: "description").value as? String {
                    description = desc
                }
                RegisterViewController.upcomingEventDict.append(eventTitle)
                RegisterViewController.upcomingEventDict.append(formLink)
                RegisterViewController.upcomingEventDict.append(whatsappLink)
                RegisterViewController.upcomingEventDict.append(img)
                RegisterViewController.upcomingEventDict.append(description)
            }
        })
    }
    
    func readEventsDB() {
        let ref = Database.database().reference().child("Events")
        var image = ""
        var title = ""
        var youtube = ""
        var desc = ""
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let allChildren = snapshot.children.allObjects as! [DataSnapshot]
            for snap in allChildren {
                if let img = snap.childSnapshot(forPath: "image").value as? String {
                    image = img
                }
                
                if let t = snap.childSnapshot(forPath: "title").value as? String {
                    title = " \(t) "
                }
                if let yt = snap.childSnapshot(forPath: "youtube").value as? String {
                    youtube = yt
                }
                if let d = snap.childSnapshot(forPath: "desc").value as? String {
                    desc = d
                }
                EventsViewController.eventsPageDict.append(eventCard(title: title, image: image, youtube: youtube, description: desc))
            }
        })
    }
    
    func readProjectsDB() {
        let ref = Database.database().reference().child("Projects")
        var image = ""
        var title = ""
        var link = ""
        var desc = ""
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let allChildren = snapshot.children.allObjects as! [DataSnapshot]
            for snap in allChildren {
                if let img = snap.childSnapshot(forPath: "image").value as? String {
                    image = img
                }
                
                if let t = snap.childSnapshot(forPath: "title").value as? String {
                    title = " \(t) "
                }
                if let l = snap.childSnapshot(forPath: "link").value as? String {
                    link = l
                }
                if let d = snap.childSnapshot(forPath: "description").value as? String {
                    desc = d
                }
                
                ProjectsViewController.projectPageDict.append(projectCard(title: title, description: desc, image: image, link: link))
            }
        })
    }
    
    func readAchievDB() {
        let ref = Database.database().reference().child("Ach")
        var image = ""
        var title = ""
        var desc = ""
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let allChildren = snapshot.children.allObjects as! [DataSnapshot]
            for snap in allChildren {
                if let img = snap.childSnapshot(forPath: "image").value as? String {
                    image = img
                }
                
                if let t = snap.childSnapshot(forPath: "Heading").value as? String {
                    title = " \(t) "
                }
                if let d = snap.childSnapshot(forPath: "SubHeading").value as? String {
                    desc = d
                }
                
                AchievementsViewController.AchievDict.append(achieveCard(title: title, description: desc, image: image))
            }
        })
    }
    func readAboutDB() {
        let ref = Database.database().reference().child("About")
        var image = ""
        var name = ""
        var email = ""
        var github = ""
        var linkedin = ""
        var position = ""
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let allChildren = snapshot.children.allObjects as! [DataSnapshot]
            for snap in allChildren {
                if let img = snap.childSnapshot(forPath: "image").value as? String {
                    image = img
                }
                
                if let n = snap.childSnapshot(forPath: "name").value as? String {
                    name = n
                }
                if let e = snap.childSnapshot(forPath: "email").value as? String {
                    email = e
                }
                if let g = snap.childSnapshot(forPath: "github").value as? String {
                    github = g
                }
                if let l = snap.childSnapshot(forPath: "linkedin").value as? String {
                    linkedin = l
                }
                if let p = snap.childSnapshot(forPath: "position").value as? String {
                    position = p
                }
                TeamsViewController.aboutDict.append(aboutCard(image: image, name: name, email: email, github: github, linkedin: linkedin, position: position))
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        readDBForHomeBlogs()
        readDBForBlogs()
        readUpcomingDB()
        readEventsDB()
        readProjectsDB()
        readAchievDB()
        readAboutDB()

        HomeViewController.blogsDict = HomeViewController.blogsDict.reversed()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.backgroundColor = UIColor.black
        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.animate()
        })
        animate()
    }
    
    private func animate(){
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width*2
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.imageView.frame = CGRect(x: -(diffX/2), y:  diffY/2, width: size, height: size )
            
            self.imageView.alpha = 0
        })
        
        
        UIView.animate(withDuration: 1, animations: {
            self.imageView.alpha = 0
        }, completion: {done in
            if done{
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                })
            }
        })
        
        
    }


}

