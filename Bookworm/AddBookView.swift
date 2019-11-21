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
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var rating = 3
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView{
            Form{
                //First section
                Section{
                    TextField("Book title", text: $title)
                    TextField("Author" , text: $author)
                    Picker(selection: $genre, label: Text("Genre")) {
                        ForEach(self.genres , id: \.self){
                            Text($0)
                        }
                    }
                }
                
                //Second section
                Section(header: Text("Genre")){
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }
                
                //Third Section
                Section{
                    Button(action: {
                        self.saveBook {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }){
                        Text("Save")
                    }
                }
            }
            .navigationBarTitle("Add Book" , displayMode: .inline)
        }
    }
        //Save book method
        func saveBook(dismiss: () -> Void){
            let book = Book(context: self.moc)
            
            book.title = self.title
            book.author = self.author
            book.genre = self.genre
            book.rating = Int16(self.rating)
            book.review = self.review
            
            try? self.moc.save()
            dismiss()
        }
    }


struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
