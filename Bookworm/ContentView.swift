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
    
    @FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true) , NSSortDescriptor(keyPath: \Book.author, ascending: true)]) var books: FetchedResults<Book>
    
    @State private var showingForm = false
    
    
    var body: some View {
        NavigationView{
            List{
                ForEach(books , id: \.self){ book in
                    NavigationLink(destination: DetailsView(book: book)) {
                
                        VStack(alignment: .leading){
                            Text(book.title ?? "Unknown Title")
                                .foregroundColor(book.rating == 1 ? Color.red : Color.black)
                                .font(.headline)
                            
                            Text(book.author ?? "Unknown Author")
                                .font(.system(size: 12))
                        }
                        
                        Spacer()
                        
                        EmojiRating_(rating: book.rating)
                        .font(.largeTitle)
                    }
                }
                .onDelete { (IndexSet) in
                    self.deleteBook(at: IndexSet)
                }
            }
            
            .navigationBarTitle("BookWorm")
            .navigationBarItems(leading: EditButton(), trailing: Button(action:{
                self.showingForm.toggle()
            }){
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingForm) {
                AddBookView().environment(\.managedObjectContext, self.moc)
            }
            
        }
        
        
    }

    func deleteBook(at offsets: IndexSet){
        for offset in offsets{
            let book = books[offset]
            
            moc.delete(book)
        }
        
        //Writes the changes done by the delete action
        try? moc.save()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
