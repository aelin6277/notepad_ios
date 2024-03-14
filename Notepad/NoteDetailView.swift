//
//  NoteDetailView.swift
//  NotepadApp
//
//  Created by Elin.Andersson on 2024-03-06.
// Detaljvy för att visa och redigera en anteckning (NoteDetailView):

import Foundation
import SwiftUI

struct NoteDetailView: View {
    var note: Note
    @ObservedObject var viewModel: NotesViewModel
    @State private var newTitle: String = ""
    @State private var newBody: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            TextField("Title", text: $newTitle)
            TextEditor(text: $newBody)
                .foregroundStyle(.secondary)
               // .font(.caption)
                .padding(.bottom, 20)
            Button("Save") {
                viewModel.updateNote(note, with: newTitle, newBody: newBody)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .onAppear {
            self.newTitle = note.title
            self.newBody = note.content
        }
    }
}
