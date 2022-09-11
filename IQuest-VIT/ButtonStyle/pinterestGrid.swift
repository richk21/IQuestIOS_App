//
//  pinterestGrid.swift
//  IQuest-VIT
//
//  Created by Richa on 21/06/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct GridItem /*Identifiable*/{
    //let id  = UUID()
    let height : CGFloat
    let title: String
    let image: String
    let link: String
}

struct pinterestGrid: View {
    
    struct Column : Identifiable{
        let id = UUID()
        var gridItems = [GridItem]()
    }
    
    //use ViewController.blogsPageDict instead of columns
    var columns = [Column]()
    let spacing: CGFloat
    let horizontalPadding: CGFloat
    @State var url = ""
    
    init(gridItems : [GridItem], numOfColumns: Int, spacing: CGFloat = 20, horizontalPadding: CGFloat = 20) {
        self.spacing = spacing
        self.horizontalPadding = horizontalPadding
        
        var columns = [Column]()
        for _ in 0 ..< numOfColumns {
            columns.append(Column())
        }
        var columnsHeight = Array<CGFloat>(repeating: 0, count: numOfColumns)
        
        for gridItem in gridItems {
            var smallestColumnIndex = 0
            var smallestHeight = columnsHeight.first!
            for i in 1 ..< columnsHeight.count {
                let curHeight = columnsHeight[i]
                if curHeight < smallestHeight {
                    smallestHeight = curHeight
                    smallestColumnIndex = i
                    
                }
            }
            columns[smallestColumnIndex].gridItems.append(gridItem)
            columnsHeight[smallestColumnIndex] += gridItem.height
        }
        
        self.columns = columns
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: spacing){
            ForEach(columns) { column in
                LazyVStack(spacing: spacing){
                    ForEach(column.gridItems, id: \.link) { gridItem in
                        //getItemView(gridItem : gridItem)
                        ZStack{
                            GeometryReader{ reader in
                                BlogCard(gridItem: gridItem)
                            }
                       }
                        .frame(height: gridItem.height)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
            }
            
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.bottom, 50)
    }
}

struct BlogCard: View{
    
    var gridItem: GridItem
    @State var url = ""
    @Environment(\.openURL) var openURL
    
    var body: some View{
        Button(action: {
            UIApplication.shared.open(URL(string: gridItem.link)!)
        }) {
            Image(gridItem.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(alignment: .center)
        }
        .overlay(
            Text(gridItem.title)
                .foregroundColor(.white)
                .background(
                    Rectangle()
                        .fill(.black).shadow(color: .black, radius: 3)
                )
                .font(.system(.title3))
                .padding(.trailing)
                .padding(.bottom)
                .padding(.leading)
            
            ,
            
            alignment: .bottomLeading
        )
    }
}

