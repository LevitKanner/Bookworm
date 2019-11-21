//
//  DetailsView.swift
//  Bookworm
//
//  Created by Levit Kanner on 21/11/2019.
//  Copyright © 2019 Levit Kanner. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailsView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    
    var book: Book
    
    var date: String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateStyle = .medium
           let date = dateFormatter.string(from: self.book.date ?? Date() )
           return date
       }
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
            
                    ZStack{
                        Image(self.book.genre ?? "Fantasy")
                            .frame(maxWidth: geometry.size.width)
                        
                        Text(self.date)
                            .offset(x: 150, y: -90)
                            .foregroundColor(.white)
                        
                        Text(self.book.genre?.uppercased() ?? "FANTASY")
                            .font(.caption)
                            .fontWeight(.black)
                        .padding(8)
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.75))
                            .offset(x: 160 , y: 80)
                        
                    }
                
                Text(self.book.author ?? "Author Unknown")
                    .font(.title)
                    .fontWeight(.black)
                    .padding(8)
                
                
                Section(header: Text("Review")
                .foregroundColor(.secondary))
                {
                    Text(self.book.review ?? "No review written for this book")
                    .padding(8)
                }
                
                //Creates a constant binding value from book rating. ie book rating can't be adjusted here...
                HStack(spacing: 20){
                    Text("Rating:")
                        .foregroundColor(.secondary)
                    RatingView(rating: .constant(Int(self.book.rating)))
                }
                .padding()
                
                  Spacer()
                    
                }
            }
            
            /*
             Adds an alert which allows a user to make a choice whether to delete the current book or cancel action
             */
        .alert(isPresented: $showingAlert, content: { () -> Alert in
            Alert(title: Text("Delete Book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("delete")){
                self.deleteBook {
                    self.presentationMode.wrappedValue.dismiss()
                }
                }, secondaryButton: .cancel())
        })
            
        .navigationBarTitle(Text(self.book.title?.uppercased() ?? "Unknown book"), displayMode: .inline)
            
            //Trailing navigation Item that triggers the deletion of a book
            .navigationBarItems(trailing: Button(action:{
                self.showingAlert = true
            }){
                Image(systemName: "trash")
            })
        }
    
    //Deletes the current book
    func deleteBook(dismiss: ()-> Void){
        self.moc.delete(book)
        dismiss()
    }
}


struct DetailsView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "The gods are to blame"
        book.author = "Chinua Achebe"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This is an excellent book I'd recommend to anyone"
        
        return NavigationView{
          DetailsView(book: book)
        }

    }
}
