//
//  AddBookView.swift
//  Bookworm
//
//  Created by Levit Kanner on 20/11/2019.
//  Copyright © 2019 Levit Kanner. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var rating = 3
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        Form{
            //First section
            Section{
                TextField("Book title", text: $title)
                TextField("Author" , text: $author)
                Picker(selection: $genre, label: Text("Genre")) {
                    ForEach(0..<self.genres.count){
                        Text(self.genres[$0])
                    }
                }
            }
            
            //Second section
            Section(header: Text("Genre")){
                Picker("Rating", selection: $rating) {
                    ForEach(0..<6){
                        Text("\($0)")
                    }
                }
                TextField("Write a review", text: $review)
            }
            
            Section{
                Button(action: {
                    //Add button action
                }){
                    Text("Save")
                }
            }
        }
        .navigationBarTitle("Add Book" , displayMode: .inline)
    }
    func saveBook(){
        let book = Book(context: self.moc)
        
        book.title = self.title
        book.author = self.author
        book.genre = self.genre
        book.rating = Int16(self.rating)
        book.review = self.review
        
        try? self.moc.save()
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
