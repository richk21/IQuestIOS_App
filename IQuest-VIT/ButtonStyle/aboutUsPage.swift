//
//  aboutUsPage.swift
//  IQuest-VIT
//
//  Created by Richa on 22/06/22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct aboutAnimatedBackground : View {
    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x: 4, y: 0)
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let color = [Color.black, Color.mint]
    var body : some View {
        LinearGradient(gradient: Gradient(colors: color), startPoint: start, endPoint: end)
            .animation(Animation.easeInOut(duration: 6).repeatForever())
            .onReceive(timer) { _ in
                self.start = UnitPoint(x: 4, y: 0)
                self.end = UnitPoint(x: 0, y: 2)
                self.start = UnitPoint(x: -4, y: 20)
                self.start = UnitPoint(x: 4, y: 0)
            }
    }
}

struct aboutUsPage: View {
    @Environment(\.presentationMode) var presentationMode
    var width = UIScreen.main.bounds.width - (40+60)
    var height = UIScreen.main.bounds.height/2
    @State var isExpanding = false
    @State var activeId = UUID()
    
    var body: some View {
        ZStack{
            aboutAnimatedBackground().edgesIgnoringSafeArea(.all)
                .zIndex(0)
            
            VStack{
                HStack{
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("chevron_left_blue")
                            .frame(width: 20, height: 20)
                            .aspectRatio(contentMode: .fit)
                            .padding(.trailing, 12)
                    }
                    Text("About Us")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.black.opacity(0.1))
                .ignoresSafeArea(.all)
                .edgesIgnoringSafeArea(.top)
                
                ScrollView(.vertical, showsIndicators: false){
                    
                    VStack{
                        ForEach(TeamsViewController.aboutDict){item in
                            expandViewAbout(isExpand: $isExpanding, activeId: $activeId, data: item)
                        }
                    }
                }
                
                
            }.background(Color.black
                            .ignoresSafeArea(.all, edges: .all)
                            .opacity(0.5))
        }
        
    }
}

struct expandViewAbout: View{
    
    @Binding var isExpand : Bool
    @Binding var activeId : UUID
    var data: aboutCard
    @State var url = ""
    
    var body : some View {
        ZStack(alignment: .top){
            HStack{
                VStack{
                    if url != ""{
                        AnimatedImage(url: URL(string: url)!)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .aspectRatio(contentMode: .fit)
                            .shadow(radius: 5)
                            .cornerRadius(25)
                    }else{
                        loader()
                    }
                }.onAppear{
                    let storage = Storage.storage().reference()
                    storage.child(data.image).downloadURL{(url, err) in
                        if err != nil{
                            return
                        }
                        
                        self.url = "\(url!)"
                            
                    }
                }
                .padding()
                //image ends here
                
                Spacer()
                VStack(alignment: .leading){
                    Text(data.name)
                        .font(.system(.title2))
                        .foregroundColor(.white)
                        .padding(.leading)
                        .padding(.trailing)
                    
                    Text(data.position)
                        .font(.system(.title3))
                        .foregroundColor(.gray)
                        .padding(.trailing)
                        .padding(.leading)
                    
                    HStack(spacing: 15){
                        //button1: Email
                        Button(action: {
                            UIApplication.shared.open(URL(string: data.email)!)
                        }) {
                            Image("aboutEmail")
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .aspectRatio(contentMode: .fit)
                        }
                        
                        //button2: LinkedIn
                        Button(action: {
                            UIApplication.shared.open(URL(string: data.linkedin)!)
                        }) {
                            Image("aboutLinkedin")
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .aspectRatio(contentMode: .fit)
                        }
                        
                        //button3: Github
                        Button(action: {
                            UIApplication.shared.open(URL(string: data.github)!)
                        }) {
                            Image("aboutGithub")
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .aspectRatio(contentMode: .fit)
                        }
                        
                    }.padding()
                }.padding()
            }
            .frame(alignment: .leading)
            .padding()
            .background(Color.black.opacity(0.5))
            
        }
        .cornerRadius(25)
        //.frame(width: Screen.width, height: self.activeId == self.data.id ? Screen.height : Screen.height * 0.45)
        .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.6))
        .padding()
        //.edgesIgnoringSafeArea(.all)
    }
}

struct aboutUsPage_Previews: PreviewProvider {
    static var previews: some View {
        aboutUsPage()
    }
}
