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

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Content", text: $content)
                Button("Add") {
                    let newNote = Note(title: title, content: content)
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

