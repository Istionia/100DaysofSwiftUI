//
//  ContentView.swift
//  WordScramble
//
//  Created by Timothy on 22/09/2022.
//

import SwiftUI

struct ContentViewActual: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("Score: \(score)")
                        .font(.headline)
                }
                
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill.indigo")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("Restart", action: startGame)
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "This word has been used already!", message: "Some originality would be more becoming...")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "This word isn't possible", message: "You can't spell that word from '\(rootWord)'.")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "This word doesn't exist in the English language", message: "Making them up, already? You can do better than that.")
            return
        }
        
        guard isNotStartWord(word: answer) else {
            wordError(title: "You've just used our start word", message: "Come on, you really can't be that obvious!")
            return
        }
        
        guard isLongerThanThreeLetters(word: answer) else {
            wordError(title: "This word is shorter than three letters", message: "Come on, give me a longer word, please?")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        score = 0
        
        fatalError("Could not load start.txt in bundle")
    }
    
    func calculateScore() {
        for word in usedWords {
            if word.count == 3 {
                score += 2
            } else if word.count == 4 {
                score += 3
            } else if word.count == 5 {
                score += 5
            } else if word.count == 6 {
                score += 8
            } else if word.count == 7 {
                score += 13
            } else {
                score += 0
            }
        }
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isNotStartWord(word: String) -> Bool {
        !usedWords.contains(rootWord)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isLongerThanThreeLetters(word: String) -> Bool {
        word.count >= 3
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    struct ContentViewActual_Previews: PreviewProvider {
        static var previews: some View {
            ContentViewActual()
        }
    }
}
