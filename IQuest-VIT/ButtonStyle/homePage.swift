//
//  homePage.swift
//  IQuest-VIT
//
//  Created by Richa on 19/06/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase


enum ActiveSheet : Identifiable{
    case zero, first, second, third, fourth, fifth, six, seven
    var id : Int{
        hashValue
    }
}
struct homeAnimatedBackground : View {
    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x: 4, y: 0)
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let color = [Color.blue, Color.black ]
    var body : some View {
        LinearGradient(gradient: Gradient(colors: color), startPoint: start, endPoint: end)
            .animation(Animation.easeInOut(duration: 15).repeatForever())
            .onReceive(timer) { _ in
                self.start = UnitPoint(x: 4, y: 0)
                self.end = UnitPoint(x: 0, y: 2)
                self.start = UnitPoint(x: -4, y: 20)
                self.start = UnitPoint(x: 4, y: 0)
            }
    }
}

struct homePage: View {
    @State var index = 0
    @State var time = Timer.publish(every: 0.1 , on: .current, in: .tracking).autoconnect()
    @State var show = false
    @State var showScreen : ActiveSheet?
    @State var url = ""
    @Environment(\.presentationMode) var presentationMode
    //var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    
    var body: some View {
        ZStack(alignment: .top, content: {
            homeAnimatedBackground().edgesIgnoringSafeArea(.all)
                //.blur(radius: 50)
                .zIndex(0)
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack{
                    GeometryReader{ g in
                        Image("stickyHeader").resizable()
                            .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
                            .frame(height: g.frame(in: .global).minY > 0 ?
                                   UIScreen.main.bounds.height / 2.2 + g.frame(in: .global).minY :
                                    UIScreen.main.bounds.height / 2.2)
                            .cornerRadius(20)
                            .aspectRatio(contentMode: .fit)
                            .onReceive(self.time) { (_) in
                                let y = g.frame(in: .global).minY
                                if -y > (UIScreen.main.bounds.height / 2.2) - 50 {
                                    withAnimation {
                                        self.show = true
                                    }
                                    
                                }else{
                                    withAnimation {
                                        self.show = false
                                    }
                                }
                            }
                    }.frame(height: UIScreen.main.bounds.height / 2.2)
                    
                    VStack{
                        
                        HStack{
                            Text("Recent Blogs")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .padding(.leading, 23)
                                .foregroundColor(.white)
                            Spacer()
                            Button(action: {
                                //go to the blogs vc
                                showScreen = .six
                            }) {
                                Text("See all")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 17))
                                    .padding()
                            }
                        }
                        //insert carousel here
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(HomeViewController.blogsDict, id: \.link){blog in
                                    homeBlogsCard(blogs: blog)
                                }
                            }
                            //.padding(.top, 20)
                            .padding(.bottom, 20)
                        }
                        
                        //add upcoming event button here
                        HStack{
                            Text("Upcoming Event")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .padding(.leading, 23)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                        Button(action: {
                            showScreen = .seven
                        }) {
                            Image("registerbtn")
                                .frame(width: UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.height/4)
                        }
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.17), radius: 20, x: 0, y: 5)
                        .padding(.bottom, 20)
                        
                        HStack{
                            Spacer()
                            Button(action: {
                                //open events view controller
                                showScreen = .zero
                            }) {
                                Image("eventsbtn")
                                    .frame(width: 190, height: 190)
                            }
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 5)
                            
                            Button(action: {
                                //open blogs view controller
                                showScreen = .first
                                
                            }) {
                                Image("blogsbtn")
                                    .frame(width: 190, height: 190)
                            }
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 5)
                            
                            Spacer(minLength: 0)
                        }
                        HStack{
                            Spacer(minLength: 0)
                            Button(action: {
                                //open projects view controller
                                showScreen = .second
                            }) {
                                Image("projectsbtn")
                                    .frame(width: 190, height: 190)
                            }
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 5)
                            
                            Button(action: {
                                //open achievements view controller
                                showScreen = .third
                            }) {
                                Image("achievebtn")
                                    .frame(width: 190, height: 190)
                            }
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 5)
                            
                            Spacer(minLength: 0)
                        }
                        HStack{
                            Spacer(minLength: 0)
                            Button(action: {
                                //open about us view controller
                                showScreen = .fourth
                            }) {
                                Image("aboutbtn")
                                    .frame(width: 190, height: 190)
                            }
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 5)
                            
                            Button(action: {
                                //open contact view controller
                                showScreen = .fifth
                            }) {
                                Image("contactbtn")
                                    .frame(width: 190, height: 190)
                            }
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 5)
                            Spacer(minLength: 0)
                        }
                        
                        Spacer(minLength: 0)
                        
                        
                    }.fullScreenCover(item: $showScreen) { item in
                        switch item{
                        case.zero :
                            showEvents()
                        case.first :
                            showBlogs()
                        case.second :
                            showProjects()
                        case.third :
                            showAchieve()
                        case.fourth:
                            showAbout()
                        case.fifth:
                            showContact()
                        case.six:
                            showBlogs()
                        case.seven:
                            showRegister()
                        }
                    }
                    Spacer()
                    
                    
                }
            })
            
            if self.show{
                topView()
            }
        })
        .edgesIgnoringSafeArea(.top)

    }
}
struct homeBlogsCard: View{
    
    var blogs: blogsCard
    @State var url = ""
    @Environment(\.openURL) var openURL
    
    var body: some View{
        
        VStack(/*alignment: .leading*/){
            Button(action: {
                //go to medium blog
                UIApplication.shared.open(URL(string: blogs.link)!)
            }) {
                VStack(alignment: .leading){
                    VStack{
                        if url != ""{
                            AnimatedImage(url: URL(string: url)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width-100, height: UIScreen.main.bounds.height/5)
                                .cornerRadius(15)
                                .padding(.top, 2)
                                .padding(.leading, 7)
                                .padding(.trailing, 7)
                                //.frame(height: UIScreen.main.bounds.height/2.6)
                        }else{
                            loader()
                        }
                    }.onAppear{
                        let storage = Storage.storage().reference()
                        storage.child(blogs.image).downloadURL{(url, err) in
                            if err != nil{
                                return
                            }
                            
                            self.url = "\(url!)"
                                
                        }
                    }
                    .padding()
                    HStack{
                        Text(blogs.title)
                            .font(.system(size: 25))
                            .minimumScaleFactor(0.01)
                            .foregroundColor(Color.black)
                            .padding(.trailing, 20)
                            .padding(.leading, 20)
                            .padding(.bottom, 5)
                        Spacer()
                    }
                    HStack{
                        Text("Tap to read")
                            .font(.system(size: 17))
                            .foregroundColor(Color.gray)
                            .padding(.trailing, 20)
                            .padding(.leading, 28)
                            .padding(.bottom, 20)
                        Spacer()
                    }
                }
            }
        }
        .background(.white)
        .frame(alignment: .leading)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.25), radius: 20, x: 5, y: 5)
        .padding(.leading, 15)
    }
}

struct homePage_Previews: PreviewProvider {
    static var previews: some View {
        homePage()
    }
}

struct topView: View{
    var body : some View{
        HStack{
            VStack(alignment: .leading, spacing: 12){
                HStack(alignment: .top){
                    Text("Innovator's Quest")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading, 30)
                    
                }
            }
            Spacer(minLength: 0)
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 5)
        .padding(.horizontal)
        .padding(.bottom)
        .background(blurBG())
        
    }
}

struct blurBG : UIViewRepresentable{
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

struct showEvents : UIViewControllerRepresentable{
    
    func makeUIViewController(context: Context) -> EventsViewController {
        let vc = EventsViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    func updateUIViewController(_ uiViewController: EventsViewController, context: Context) {
        
    }
}

struct showBlogs : UIViewControllerRepresentable{
    
    func makeUIViewController(context: Context) -> BlogsViewController {
        let vc = BlogsViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    func updateUIViewController(_ uiViewController: BlogsViewController, context: Context) {
        
    }
}
struct showProjects : UIViewControllerRepresentable{
    
    func makeUIViewController(context: Context) -> ProjectsViewController {
        let vc = ProjectsViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ProjectsViewController, context: Context) {
        
    }
}
struct showAchieve : UIViewControllerRepresentable{
    
    func makeUIViewController(context: Context) -> AchievementsViewController {
        let vc = AchievementsViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    func updateUIViewController(_ uiViewController: AchievementsViewController, context: Context) {
        
    }
    
}
struct showAbout : UIViewControllerRepresentable{
    
    func makeUIViewController(context: Context) -> TeamsViewController {
        let vc = TeamsViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    func updateUIViewController(_ uiViewController: TeamsViewController, context: Context) {
        
    }
}
struct showContact : UIViewControllerRepresentable{
    
    func makeUIViewController(context: Context) -> ContactViewController {
        let vc = ContactViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ContactViewController, context: Context) {
        
    }
}

struct showRegister : UIViewControllerRepresentable{
    
    func makeUIViewController(context: Context) -> RegisterViewController {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    func updateUIViewController(_ uiViewController: RegisterViewController, context: Context) {
        
    }
}

