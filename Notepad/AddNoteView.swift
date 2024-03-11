//
//  AddNoteView.swift
//  NotepadApp
//
//  Created by Elin.Andersson on 2024-03-06.
//

import Foundation
import SwiftUI

struct AddNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: NotesViewModel
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var date: Date = Date()

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextEditor(text: $content)
                    .foregroundStyle(.secondary)
                Button("Add") {
                    let newNote = Note(title: title, content: content, date: date)
                    viewModel.addNote(newNote)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarTitle("New Note", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

