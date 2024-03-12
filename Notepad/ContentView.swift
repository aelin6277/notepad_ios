//
//  ContentView.swift
//  NotepadApp
//
//  Created by Elin.Andersson on 2024-03-06.
//HUVUD VIEW (NOTEPADAPP)

//Att skapa en NotePad-app i SwiftUI innebär att jag kommer att följa en MVVM-arkitektur (Model-View-ViewModel) för att hålla koden organiserad och följa SwiftUI:s designprinciper. Jag använder UserDefaults för att enkelt lagra anteckningarna på enheten, vilket är lämpligt för enkel data och små projekt som detta. Hade från början tänk anv core data men det kändes ej nödvändigt senare.

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NotesViewModel()
    @State private var showingAddNoteView = false
    
    var formatter = RelativeDateTimeFormatter()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note, viewModel: viewModel)) {
                        Text(note.title)
                        
                        Text(formatter.localizedString(for: note.date, relativeTo: Date()))
                        .foregroundStyle(.secondary)
                            
                    }
                }
                .onDelete(perform: viewModel.deleteNote)
            }
            .navigationBarTitle("Notes")
            .navigationBarItems(trailing: Button(action: {
                self.showingAddNoteView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddNoteView) {
                AddNoteView(viewModel: viewModel)
            }
        }
    }
}
