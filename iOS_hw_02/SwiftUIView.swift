//
//  SwiftUIView.swift
//  iOS_hw_02
//
//  Created by CK on 2021/3/21.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State var showGamePage = false
    var body: some View {
        Button(action: {showGamePage = true
            card.shuffle()
            licensing()
            sortCard()
        },label: {Text("start").font(.largeTitle)
            
        })
        .sheet(isPresented: $showGamePage, content:{
            ContentView()
        })
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
