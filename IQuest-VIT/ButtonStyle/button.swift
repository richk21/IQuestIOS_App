//
//  button.swift
//  IQuest-VIT
//
//  Created by Richa on 31/05/22.
//

import SwiftUI

struct button: View {
    var body: some View {
        VStack {
            Button {
                print("this is the button")
            }label: {
                Text("Learn More")
        }
        }
    }
}

struct button_Previews: PreviewProvider {
    static var previews: some View {
        button()
    }
}
