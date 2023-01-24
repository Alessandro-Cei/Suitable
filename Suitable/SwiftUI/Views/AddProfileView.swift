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
    @State var profiletemp = (Profile(name: "", surname: "", birthDate: Date(), image: "ImageProfile", description: "", tags: [], links: [], role: "", quote: "", displayName: ""))
    @State var linktemp = ""
    @State var tags = ["CoreData", "SpriteKit", "UiKit"]
    @State private var disabled = true
    let textLimit = 70
    
    var body: some View {
        
        NavigationView{
                Form {
                    
                    Image(profiletemp.image)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
//                        .frame(width: 110,height: 110)
                        .padding(.leading, 30)
                    
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
                        
                        TextField("Role", text: $profiletemp.role)
                        TextField("Quote", text: $profiletemp.quote)
                            .onReceive(profiletemp.quote.publisher.collect()) {
                                let s = String($0.prefix(textLimit))
                                if profiletemp.quote != s {
                                    profiletemp.quote = s
                                }
                            }
                        
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
                                            .opacity(0.2)
                                        Text(tag)
                                            .font(.callout)
                                        
                                    }
                                    .cornerRadius(30)
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
                        .disabled(profiletemp.name == "" || profiletemp.surname == "" || profiletemp.role == "" ? true : false)
                        
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

