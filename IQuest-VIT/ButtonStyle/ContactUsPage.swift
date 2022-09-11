//
//  ContactUsPage.swift
//  IQuest-VIT
//
//  Created by Richa on 13/06/22.
//

import SwiftUI
import MessageUI
import Foundation

struct ComposeMailData {
  let subject: String
  let recipients: [String]?
  let message: String
  let attachments: [AttachmentData]?
}

struct AttachmentData {
  let data: Data
  let mimeType: String
  let fileName: String
}

typealias MailViewCallback = ((Result<MFMailComposeResult, Error>) -> Void)?

struct MailView: UIViewControllerRepresentable {
  @Environment(\.presentationMode) var presentation
  @Binding var data: ComposeMailData
  let callback: MailViewCallback

  class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
    @Binding var presentation: PresentationMode
    @Binding var data: ComposeMailData
    let callback: MailViewCallback

    init(presentation: Binding<PresentationMode>,
         data: Binding<ComposeMailData>,
         callback: MailViewCallback) {
      _presentation = presentation
      _data = data
      self.callback = callback
    }

    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
      if let error = error {
        callback?(.failure(error))
      } else {
        callback?(.success(result))
      }
      $presentation.wrappedValue.dismiss()
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(presentation: presentation, data: $data, callback: callback)
  }

  func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
    let vc = MFMailComposeViewController()
    vc.mailComposeDelegate = context.coordinator
    vc.setSubject(data.subject)
    vc.setToRecipients(data.recipients)
    vc.setMessageBody(data.message, isHTML: false)
    data.attachments?.forEach {
      vc.addAttachmentData($0.data, mimeType: $0.mimeType, fileName: $0.fileName)
    }
    vc.accessibilityElementDidLoseFocus()
    return vc
  }

  func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                              context: UIViewControllerRepresentableContext<MailView>) {
  }

  static var canSendMail: Bool {
    MFMailComposeViewController.canSendMail()
  }
}

struct ContactUsPage: View {
    
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    @State private var isShowingMailView = false
    @State var url = ""
    @State var time = Timer.publish(every: 0.1 , on: .current, in: .tracking).autoconnect()
    @State var show = false
    @Environment(\.presentationMode) var presentationMode
    @State private var mailData = ComposeMailData(subject: "A subject",
                                                    recipients: ["iquestvit@gmail.com"],
                                                    message: "Insert your message here",
                                                    attachments: [AttachmentData(data: "Some text".data(using: .utf8)!,
                                                                                 mimeType: "text/plain",
                                                                                 fileName: "text.txt")
                                                   ])
     @State private var showMailView = false
    var height = UIScreen.main.bounds.height/2
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            GeometryReader{ reader in
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image("chevron_left_blue")
                        .frame(width: 20, height: 20)
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 40*(896/height))
                        .padding(.leading, 12)
                }
                .zIndex(1)
                
                Image("contactLogo").resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(y: -reader.frame(in: .global).minY)
                    .frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).minY + 480)
                    .onReceive(self.time) { (_) in
                        let y = reader.frame(in: .global).minY
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
                    .zIndex(0)
            }
            
            .frame(height: 480)
            
            VStack(alignment: .leading, spacing: 15){
                Text(("Get in Touch")).font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Have any questions? We'd love to hear from you!").padding(.top, 10)
                    .foregroundColor(Color.white)
                
                VStack(alignment: .leading, spacing: 8){
                //mail button
                Button(action: {
                    showMailView.toggle()
                }, label: {
                    HStack{
                        Image("emailw").padding(.leading, 20)
                    Text("Write to us")
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                            .padding(.vertical, 20)
                            .padding(.trailing, 20)
                    }
                }).disabled(!MailView.canSendMail)
                        .sheet(isPresented: $showMailView) {
                          MailView(data: $mailData) { result in
                            print(result)
                           }
                        }
                        .background(Color.black)
                        .cornerRadius(50, antialiased: true)
                        .overlay(RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.white, lineWidth: 2)
                        )
                
                //linkedin button
                Button(action: {
                    guard let url = URL(string: "https://in.linkedin.com/company/innovatorsquest") else {
                      return
                    }
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }, label: {
                    HStack{
                        Image("linkedin-logow").padding(.leading, 20)
                        Text("Our LinkedIn")
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                            .padding(.vertical, 20)
                            .padding(.trailing, 20)
                    }
                }).background(Color.blue)
                        .cornerRadius(50, antialiased: true)
                
                //instagram button
                Button(action: {
                    guard let url = URL(string: "https://www.instagram.com/iquest.vit/?hl=en") else {
                      return
                    }
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }, label: {
                    HStack{
                    Image("instagramw")
                            .padding(.leading, 20)
                    Text("Our Instagram")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 20)
                        .padding(.trailing, 20)
                    }
                }).background(Color.pink)
                        .cornerRadius(50, antialiased: true)
                
                //twitter
                Button(action: {
                    guard let url = URL(string: "https://twitter.com/innovatorsvit") else {
                      return
                    }
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }, label: {
                    HStack{
                    Image("twitterw")
                            .padding(.leading, 20)
                    Text("Our twitter")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 20)
                        .padding(.trailing, 20)
                    }
                }).background(Color.cyan)
                        .cornerRadius(50, antialiased: true)
                
                //youtube
                Button(action: {
                    guard let url = URL(string: "https://www.youtube.com/channel/UC07_a96S__f53ySk_5H7jCA") else {
                      return
                    }
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }, label: {
                    HStack{
                    Image("youtubew")
                            .padding(.leading, 20)
                    Text("Our Youtube Channel")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 20)
                        .padding(.trailing, 20)
                    }
                    
                }).background(Color.red)
                        .cornerRadius(50, antialiased: true)
                
                //facebook
                Button(action: {
                    guard let url = URL(string: "https://www.facebook.com/InnovatorsQuest/") else {
                      return
                    }
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }, label: {
                    HStack{
                    Image("facebookw")
                            .padding(.leading, 20)
                    Text("Our Facebook")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 20)
                        .padding(.trailing, 20)
                }
                }).background(Color.indigo)
                        .cornerRadius(50, antialiased: true)
                    
                //github
                Button(action: {
                    guard let url = URL(string: "https://github.com/Innovators-Quest-VITVellore") else {
                      return
                    }
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }, label: {
                    HStack{
                    Image("githubw")
                            .padding(.leading, 20)
                    Text("Our Github")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 20)
                        .padding(.trailing, 20)
                }
                }).background(Color.black)
                        .cornerRadius(50, antialiased: true)
                        .overlay(RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.white, lineWidth: 2)
                        )
                    
                }.padding(.top, 10)
                    .padding(.bottom, 40)

            }
            .padding(.top, 25)
            .padding(.horizontal)
            .background(Color.black)
            .cornerRadius(20)
            .offset(y: -35)
            
        }).edgesIgnoringSafeArea(.all)
            .background(Color.gray.edgesIgnoringSafeArea(.all))
            
    }
}

struct ContactUsPage_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsPage()
    }
}

