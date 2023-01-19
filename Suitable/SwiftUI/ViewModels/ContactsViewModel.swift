//
//  ContactsViewModel.swift
//  Suitable
//
//  Created by Martina Esposito on 19/01/23.
//

import Foundation

class ContactViewModel: ObservableObject{

    @Published var contacts: [Profile] = [
        
        Profile(name: "Nime", surname: "Cognome", birthDate: "", image: "", description: "", tags: [], links: [], backgroundColor: []),
        Profile(name: "Nime", surname: "Cognome", birthDate: "", image: "", description: "", tags: [], links: [], backgroundColor: []),
        Profile(name: "Nime", surname: "Cognome", birthDate: "", image: "", description: "", tags: [], links: [], backgroundColor: []),
        Profile(name: "Nime", surname: "Cognome", birthDate: "", image: "", description: "", tags: [], links: [], backgroundColor: []),
        Profile(name: "Nime", surname: "Cognome", birthDate: "", image: "", description: "", tags: [], links: [], backgroundColor: []),
        Profile(name: "Nime", surname: "Cognome", birthDate: "", image: "", description: "", tags: [], links: [], backgroundColor: [])
    ]

    func addContact(contact: Profile) -> Void{
        self.contacts.append(contact)
    }

}

var contacts1 = ContactViewModel()
