//
//  parallaxEffect.swift
//  IQuest-VIT
//
//  Created by Richa on 13/06/22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

var upcomingTitle = RegisterViewController.upcomingEventDict[0]
var upcomingWhatsappGroup = RegisterViewController.upcomingEventDict[2]
var upcomingRegistrationForm = RegisterViewController.upcomingEventDict[1]
var imgLink = RegisterViewController.upcomingEventDict[3]
var eventDescription = RegisterViewController.upcomingEventDict[4]

struct loader: UIViewRepresentable{
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
    }
}

struct parallaxEffect: View {
    
    @State var url = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            GeometryReader{ reader in
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image("chevron_left_blue")
                        .frame(width: 20, height: 20)
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 40)
                        .padding(.leading, 12)
                }
                .zIndex(1)
                VStack{
                    if url != ""{
                        AnimatedImage(url: URL(string: url)!).resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(y: -reader.frame(in: .global).minY)
                            .frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).minY + 480)
                    }else{
                        loader()
                    }
                }.onAppear{
                    print("\n\nPOSTER OF UPCOMING EVENT IS READY!\n\n\n")
                    let storage = Storage.storage().reference()
                    storage.child(imgLink).downloadURL{(url, err) in
                        if err != nil{
                            return
                        }
                        
                        self.url = "\(url!)"
                            
                    }
                }
                .zIndex(0)
            }
            .frame(height: 480)
            VStack(alignment: .leading, spacing: 15){
                Text((upcomingTitle)).font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                
                Text(eventDescription).padding(.top, 10)
                    .foregroundColor(Color.white)
                
            }
            .padding(.top, 25)
            .padding(.horizontal)
            .background(Color.black)
            .cornerRadius(20)
            .offset(y: -35) //till point
            
            HStack(spacing: 15){
                
                Button(action: {
                    guard let url = URL(string: upcomingWhatsappGroup) else {
                      return
                    }
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }, label: {
                    Text("Whatsapp Group")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 20)
                        .background(Color.green)
                        .cornerRadius(30)
                })
                
                Button(action: {
                    guard let url = URL(string: upcomingRegistrationForm) else {
                      return
                    }
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }, label: {
                    Text("Form Link")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 20)
                        .background(Color.indigo)
                        .cornerRadius(30)
                })
                
                
            }.padding(.top, 10)
                .padding(.bottom, 40)
            
        }).edgesIgnoringSafeArea(.all)
            .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct parallaxEffect_Previews: PreviewProvider {
    static var previews: some View {
        parallaxEffect()
    }
}

