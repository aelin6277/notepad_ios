//
//  NotesViewModel.swift
//  NotesViewModel
//
//  Created by Elin.Andersson on 2024-03-06.

//NotesViewModel kommer att hantera all logik för att lägga till, ta bort och uppdatera anteckningar. Den kommer också att ansvara för att ladda och spara anteckningar till UserDefaults.

import Foundation
class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []

    init() {
        loadNotes()
    }

    func addNote(_ note: Note) {
        let newNote = note
        notes.append(newNote)
        notes.sort(by: { $0.date > $1.date })
        saveNotes()
    }

    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        saveNotes()
    }

    func updateNote(_ note: Note, with newTitle: String, newBody: String) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].title = newTitle
            notes[index].content = newBody
            notes[index].date = Date()
            saveNotes()
        }
    }

    private func loadNotes() {
        if let notesData = UserDefaults.standard.data(forKey: "notes"),
           let decodedNotes = try? JSONDecoder().decode([Note].self, from: notesData) {
            self.notes = decodedNotes.sorted(by: { $0.date > $1.date })
        }
    }

    private func saveNotes() {
        if let encodedNotes = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encodedNotes, forKey: "notes")
        }
    }
}

