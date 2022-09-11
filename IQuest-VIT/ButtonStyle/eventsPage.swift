//
//  eventsPage.swift
//  IQuest-VIT
//
//  Created by Richa on 15/06/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct eventsAnimatedBackground : View {
    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x: 4, y: 0)
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let color = [Color.red, Color.black]
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

struct eventsPage: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack(alignment: .top, content: {
            eventsAnimatedBackground().edgesIgnoringSafeArea(.all)
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
                    Text("Events")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.black.opacity(0.5))
                .zIndex(0)
                
                
                GeometryReader{mainView in
                    ScrollView{
                        VStack(spacing: 24){
                            ForEach(EventsViewController.eventsPageDict, id: \.title){event in
                                
                                GeometryReader{item in
                                    
                                    eventCardView(events: event)
                                        .scaleEffect(scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY))
                                    
                                        .opacity(Double(scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY)))
                                }.frame(height: 550)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 25)
                        .padding(.bottom, 100)
                        
                    }.padding(.trailing, 20)
                        .padding(.leading, 20)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                        .zIndex(1)
                    
                }
                
                
            }//.background(Color.black.opacity(0.9).edgesIgnoringSafeArea(.all))
            .edgesIgnoringSafeArea(.top)
            .zIndex(1)
        })
        
    }
    
    //calculation for scale value
    func scaleValue(mainFrame: CGFloat, minY: CGFloat)->CGFloat{
        withAnimation(.easeOut){
            let scale = (minY-10*(mainFrame/896))/mainFrame
            if(scale > 1){
                return 1
            }else{
                return scale
            }
        }
    }
}

struct eventCardView: View{
    
    var events: eventCard
    @State var url = ""
    
    var body: some View{
        
        VStack(alignment: .leading){
            VStack{
                if url != ""{
                    AnimatedImage(url: URL(string: url)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        //.frame(width: 300, height: 183)
                        .cornerRadius(15)
                        .padding(.top, 2)
                        .padding(.leading, 2)
                        .padding(.trailing, 2)
                        .frame(height: 340)
                }else{
                    loader()
                }
            }.onAppear{
                let storage = Storage.storage().reference()
                storage.child(events.image).downloadURL{(url, err) in
                    if err != nil{
                        return
                    }
                    
                    self.url = "\(url!)"
                        
                }
            }
            
            Text(events.title)
                .font(.system(size: 30))
                .foregroundColor(Color.black)
                .fontWeight(.bold)
                .padding(.trailing, 20)
                .padding(.leading, 10)
            Spacer(minLength: 0)
            Text(events.description)
                .foregroundColor(Color.gray)
                .padding(.vertical, 6)
                .padding(.trailing, 20)
                .padding(.leading, 10)
            
            VStack(alignment: .leading, spacing: 12){
                Button(action: {
                    guard let url = URL(string: events.youtube) else {
                      return
                    }
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }) {
                    HStack(){
                        Image("youtuber").padding(.leading, 20)
                    
                        Text("Watch now!")
                            .font(.system(size: 20))
                            .foregroundColor(Color.red)
                            .fontWeight(.bold)
                            .padding(.vertical, 20)
                            .padding(.trailing, 20)
                    }
                }
            }
        }
        .background(Color.white.shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 4))
        .frame(alignment: .leading)
        .cornerRadius(15)
    }
}

struct eventsPage_Previews: PreviewProvider {
    static var previews: some View {
        //eventCardView(events: eventCard(title: "h", image: "h", youtube: "h", description: "H"))
        eventsPage()
    }
}
