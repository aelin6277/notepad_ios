//
//  ContentView.swift
//  NotepadApp
//
//  Created by Elin.Andersson on 2024-03-06.
//HUVUD VIEW

//Att skapa en NotePad-app i SwiftUI innebär att vi kommer att följa en MVVM-arkitektur (Model-View-ViewModel) för att hålla koden organiserad och följa SwiftUI:s designprinciper. Vi kommer att använda UserDefaults för att enkelt lagra anteckningarna på enheten, vilket är lämpligt för enkel data och små projekt som detta. För större eller mer komplex data rekommenderas Core Data eller andra databaslösningar.

import SwiftUI
import CoreData
struct ContentView: View {
    @StateObject private var viewModel = NotesViewModel()
    @State private var showingAddNoteView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note, viewModel: viewModel)) {
                        Text(note.title)
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
