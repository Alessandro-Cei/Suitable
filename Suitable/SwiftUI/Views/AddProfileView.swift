//
//  AddProfileView.swift
//  Suitable
//
//  Created by Martina Esposito on 19/01/23.
//

import SwiftUI

struct AddProfileView: View {
    
    @Binding var showsheet: Bool
    @ObservedObject var portfolio: ProfileViewModel
    @State var profiletemp = (Profile(name: "", surname: "", birthDate: Date(), image: "", description: "", tags: [], links: [], displayName: ""))
    @State var linktemp = ""
    @State var tags = ["Swiftui", "CoreData", "SpriteKit", "UiKit"]
    @State private var disabled = true
    var body: some View {
        
        NavigationView{
            
            Form {
                
                Image(systemName: "person.circle")
                    .resizable()
                    .foregroundColor(.blue)
                    .font(Font.system(size: 100, weight: .light))
                    .frame(width: 100,height: 100)
                    .padding(.leading, 100)
                
                Section(header: Text("PROFILE")) {
                    TextField("Name", text: $profiletemp.name)
                    TextField("Surname", text: $profiletemp.surname)
                    DatePicker(
                        "Birthdate",
                        selection: $profiletemp.birthDate,
                        displayedComponents: [.date]
                        )
//                   TextField("Birthdate", text: $profiletemp.birthDate)
                }
                
                Section(header: Text("ABOUT YOU")) {
                    TextField("Description", text: $profiletemp.description/* , axis: .vertical*/).lineLimit(30)
                    //                    TextField("Links", text: String($profiletemp.links[i]))
                    
                }
                Section(header: Text("LINKS")) {
                    
                    HStack{
                        TextField("Links", text: $linktemp)
                    }
                }
                
                Section(header: Text("Tags")) {
                    HStack{
                        
                        ForEach(tags, id: \.self){ tag in
                            Button(action: {
                                
                                
                                if !(profiletemp.tags?.contains(tag) ?? false) {
                                    profiletemp.tags?.append(tag)
                                    
                                } else {
                                    if let index = profiletemp.tags!.firstIndex(of: tag) {
                                        profiletemp.tags?.remove(at: index)
                                        
                                    }
                                }
                                
                            }, label: {
                                
                                ZStack{
                                    Rectangle()
                                        .frame(height: 30)
                                        .foregroundColor( profiletemp.tags!.contains(tag) ? .red : .blue)
                                        .opacity(0.3)
                                    Text(tag)
                                        .font(.callout)
                                    
                                }
                                .cornerRadius(10)
                            })
                        }
                    }
                    .frame(height: 60)
                    .buttonStyle(BorderlessButtonStyle())
                }
                
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        showsheet.toggle()
                        portfolio.addProfile(profile: profiletemp)
                    }, label: {
                        Text("Save")
                    })
                    .disabled(profiletemp.name == "" || profiletemp.surname == "" ? true : false)
                    
                }
            }
        }
        
    }
}



struct AddProfileView_Previews: PreviewProvider {
        static var previews: some View {
            AddProfileView(showsheet: .constant(true), portfolio: profile1)
    }
}

