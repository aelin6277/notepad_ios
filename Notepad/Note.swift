//
//  Note.swift
//  NotepadApp
//
//  Created by Elin.Andersson on 2024-03-06.
//Skapa en Note-struktur som representerar en anteckning.

import Foundation

struct Note: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var content: String
    var date: Date
}
