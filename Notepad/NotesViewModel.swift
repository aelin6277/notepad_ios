//
//  NotesViewModel.swift
//  NotesViewModel
//
//  Created by Elin.Andersson on 2024-03-06.
//NotesViewModel kommer att hantera all logik för att lägga till, ta bort och uppdatera anteckningar. Den kommer också att ansvara för att ladda och spara anteckningar till UserDefaults.

//I det här fallet behöver NotesViewModel-klassen endast importera Foundation för grundläggande funktionalitet som att arbeta med UserDefaults, kodning/dekodning (Codable), och hantera samlingar som Array. ObservableObject och @Published som används för att skapa bindningar mellan dina SwiftUI-vyer och denna viewmodel ingår också i Foundation när du arbetar med SwiftUI.
//Om din Note-struktur ligger i en separat fil och den inte använder specifika SwiftUI-egenskaper eller andra bibliotek, behöver den filen också bara importera Foundation.

//Däremot, om du använder UI-element, vyer, eller vissa specifika funktioner från SwiftUI i din viewmodel (vilket är mindre vanligt eftersom viewmodellen bör hållas separerad från vyer), skulle du behöva lägga till import SwiftUI i toppen av din fil. Men för det här exemplet och för de flesta MVVM-mönster i SwiftUI bör import Foundation vara tillräckligt för din viewmodel.

import Foundation
class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []

    init() {
        loadNotes()
    }

    func addNote(_ note: Note) {
        notes.append(note)
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
            self.notes = decodedNotes
        }
    }

    private func saveNotes() {
        if let encodedNotes = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encodedNotes, forKey: "notes")
        }
    }
}

