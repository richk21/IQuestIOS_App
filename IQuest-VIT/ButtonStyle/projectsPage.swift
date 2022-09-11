//
//  projectsPage.swift
//  IQuest-VIT
//
//  Created by Richa on 16/06/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct projectsAnimatedBackground : View {
    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x: 4, y: 0)
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let color = [Color.black, Color.indigo]
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

struct projectsPage: View {
    
    @Environment(\.presentationMode) var presentationMode
    var width = UIScreen.main.bounds.width - (40+60)
    var height = UIScreen.main.bounds.height/2
    @State var isExpanding = false
    @State var activeId = UUID()
    
    var body: some View {
        ZStack{
            projectsAnimatedBackground().edgesIgnoringSafeArea(.all)
                .zIndex(0)
            
            VStack{
                HStack{
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("chevron_left_blue")
                            .frame(width: 20, height: 20)
                            .aspectRatio(contentMode: .fit)
                            //.padding(.top, 40)
                            //.padding(.leading, 12)
                            .padding(.trailing, 12)
                    }
                    Text("Projects")
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
                    
                    VStack(spacing: 30*(896/height)){
                        ForEach(ProjectsViewController.projectPageDict){item in
                            GeometryReader{ reader in
                                
                                //expandView(isExpand: $isExpanding, data: item, activeId: $activeId)
                                expandView(isExpand: $isExpanding, activeId: $activeId, data: item)
                                    .offset(y: self.activeId == item.id ? -reader.frame(in: .global).minY : 0)
                                    .opacity(self.activeId != item.id && self.isExpanding ? 0 : 1)
                                
                            }.frame(height: Screen.height*0.45)
                                .frame(maxWidth: self.isExpanding ? Screen.width : Screen.width*0.9 )
                                .padding(.top)
                                .padding(.bottom)
                            
                        }
                    }
                }.padding(.bottom)
                
                
            }.background(Color.black
                            .ignoresSafeArea(.all, edges: .all)
                            .opacity(0.5))
        }
        
    }
}

struct expandView: View{
    
    @Binding var isExpand : Bool
    @Binding var activeId : UUID
    var data: projectCard
    @State var url = ""
    
    var body : some View {
        
        Button(action: {
            UIApplication.shared.open(URL(string: data.link)!)
        }) {
            ZStack(alignment: .top){
                VStack{
                    if url != ""{
                        AnimatedImage(url: URL(string: url)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .shadow(radius: 5)
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
                
                //title here
                HStack{
                    VStack(alignment: .leading, spacing: 0){
                        Text(data.title)
                            .font(.system(.title))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                        Text(data.description)
                            .font(.system(.title3))
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                            .padding()
                        
                        
                    }
                    Spacer()
                }.padding()
                    .background(Color.black
                                    .opacity(0.5)
                                    .blur(radius: 5))
            }
            .frame(width: Screen.width, height: self.activeId == self.data.id ? Screen.height : Screen.height * 0.45)
            .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.6))
            .edgesIgnoringSafeArea(.all)
        }
        .padding(.top)
    }
}

struct Screen {
    static let height = UIScreen.main.bounds.height
    static let width = UIScreen.main.bounds.width
}
