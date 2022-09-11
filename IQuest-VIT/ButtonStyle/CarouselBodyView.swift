//
//  CarouselBodyView.swift
//  IQuest-VIT
//
//  Created by Richa on 14/06/22.
//

import SwiftUI

struct CarouselBodyView: View {
    var index: Int
    var body: some View {
        GeometryReader{proxy in
            let size = proxy.size
            ZStack{
                Image("pic2") //image("projectImage\(index)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width-8, height: size.height/1.2)
                    .cornerRadius(12)
                
                VStack{
                    Spacer(minLength: 0)
                    VStack(spacing: 25){
                        VStack(alignment: .leading, spacing: 6){
                            Text("Project Title")
                                .font(.title2.bold())
                            Text("Project description")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .background(.white)
                        .foregroundStyle(.black)
                    
                }.padding(.top, 100)
            }
            .frame(width: size.width, height: size.height)
            .frame(width: size.width-8, height: size.height/1.2)
        }.tag("pic") // tag("projectImage\(index)")
    }
}

struct CarouselBodyView_Previews: PreviewProvider {
    static var previews: some View {
        projectsPage()
    }
}
