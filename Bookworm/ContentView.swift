//
//  ContentView.swift
//  Bookworm
//
//  Created by Levit Kanner on 20/11/2019.
//  Copyright © 2019 Levit Kanner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(entity: Book.entity(), sortDescriptors: <#T##[NSSortDescriptor]#>) var books: FetchedResults<Book>
    
    var body: some View {
        Text("Hello World!")

            
        .navigationBarItems(leading: Button(action:{
            
        }){
            Image(systemName: "plus")
        })
        .disabled(<#T##disabled: Bool##Bool#>)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
