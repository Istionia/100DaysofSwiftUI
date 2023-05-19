//
//  AddBookView.swift
//  Bookworm
//
//  Created by Timothy on 07/11/2022.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    @State private var date = Date.now
    
    var hasValidAddress: Bool {
        for field in [title, author, genre] {
            if field.trimmingCharacters(in: .whitespaces).isEmpty { return false }
        }
        
        return true
    }
    
    let genres = [
        "Fantasy",
                      "Science Fiction",
                      "Adventure",
                      "Romance",
                      "Detective & Mystery",
                      "Horror",
                      "Thriller",
                      "LGBTQ+",
                      "Historical Fiction",
                      "Young Adult (YA)", "Children's Fiction",
                      "Memoir & Autobiography",
                      "Biography",
                      "Cooking",
                      "Art & Photography",
                      "Self-Help/Personal Development",
                      "Motivational/Inspirational",
                      "Health & Fitness",
                      "History",
                      "Crafts, Hobbies & Home",
                      "Families & Relationships",
                      "Humor & Entertainment",
                      "Business, Finance & Money",
                      "Law & Criminology",
                      "Politics & Social Sciences",
                      "Religion & Spirituality",
                      "Education & Teaching",
                      "Travel", "Science",
                      "True Crime"
    ]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save"){
                        // Time to add the book!
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = date

                        try? moc.save()
                        dismiss()
                    }
                }
                .disabled(hasValidAddress == false)
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
