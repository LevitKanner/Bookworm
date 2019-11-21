//
//  ContentView.swift
//  Bookworm
//
//  Created by Levit Kanner on 20/11/2019.
//  Copyright © 2019 Levit Kanner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    @State private var showingForm = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(books , id: \.id){book in
                    Text(book.title ?? "Unknown")
                }
                Text("\(self.books.count)")
            }
            
            .navigationBarTitle("BookWorm")
            .navigationBarItems(trailing: Button(action:{
                self.showingForm.toggle()
            }){
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingForm) {
                AddBookView().environment(\.managedObjectContext, self.moc)
            }
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
