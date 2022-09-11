//
//  blogsPage.swift
//  IQuest-VIT
//
//  Created by Richa on 21/06/22.
//

import SwiftUI

struct blogsPage: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        HStack{
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image("chevron_left_blue")
                    .frame(width: 20, height: 20)
                    .aspectRatio(contentMode: .fit)
                    .padding(.trailing, 12)
            }
            Text("Blogs")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .foregroundColor(.black)
            Spacer(minLength: 0)
        }
        .padding()
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .background(Color.white.shadow(color: Color.black.opacity(0.18), radius: 5, x: 0, y: 5))
        .zIndex(0)
        
        ScrollView{
            pinterestGrid(gridItems: BlogsViewController.gridItems, numOfColumns: 2, spacing: 10, horizontalPadding: 10)
        }
    }
}

struct blogsPage_Previews: PreviewProvider {
    static var previews: some View {
        blogsPage()
    }
}
