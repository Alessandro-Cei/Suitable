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
    @State var profiletemp = (Profile(name: "", surname: "", birthDate: "", image: "", description: "", tags: [], links: [], backgroundColor: []))
//    @State var linkstemp: [String] = []
    @State var linktemp = ""
    @State var tags = ["Swiftui", "CoreData", "SpriteKit", "UiKit"]
    @State private var disabled = true
//    @State var i = 0
//    @State var addlink = false
//    @State var tapped = false
    
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
                    TextField("Birthdate", text: $profiletemp.birthDate)
                }
                
                Section(header: Text("ABOUT YOU")) {
                    TextField("Description", text: $profiletemp.description)
                    //                    TextField("Links", text: String($profiletemp.links[i]))
                    
                }
                Section(header: Text("LINKS")) {
                    
                    HStack{
                        TextField("Links", text: $linktemp)
                        //
                        //                        Button(action: {
                        //                            addlink.toggle()
                        //                            i += 1
                        //                        }, label: {
                        //                            Image(systemName: "plus.circle")
                        //                        })
                    }
                    
                    //                    Button(action: {
                    //                        addlink.toggle()
                    //                        i += 1
                    //                    }, label: {
                    //                        Image(systemName: "plus.circle")
                    //                    })
                    
                    //                    ForEach (1...linkstemp.count, id: \.self) { i in
                    //
                    //    //                        profile.links.append(URL.init(string: link))
                    //    //                        TextField("Links", text: String($profiletemp.links[i]))
                    ////                        TextField("Links", text: $linkstemp[i])
                    //                        TextField("Links", text: $linkstemp[i])
                    //
                    //                    }
                    
                }
                    
                Section(header: Text("Tags")) {
                        HStack{
                            
                            ForEach(tags, id: \.self){ tag in
                                Button(action: {
                                    
                                    
                                    if !profiletemp.tags.contains(tag) {
                                        profiletemp.tags.append(tag)
                                        
                                    } else {
                                        if let index = profiletemp.tags.firstIndex(of: tag) {
                                            profiletemp.tags.remove(at: index)
                                        }
                                    }
                                    
                                }, label: {
                                    
                                    ZStack{
                                        Rectangle()
                                            .frame(height: 30)
                                            .foregroundColor( profiletemp.tags.contains(tag) ? .red : .blue)
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
//                        profile = profiletemp
//                        profile.links.append(URL(string: linktemp))
                        
//                            for 1...linkstemp.count {
//
//                                profile.links[j] = URL(string: linkstemp[j])!
//                            }
                        
//                            ForEach(1...linkstemp.count, id: \.self){ i in
//
//                                profile.links.append(URL(string: linkstemp[i])!)
//                            }
                    }, label: {
                        Text("Save")
                    })
                    .disabled(profiletemp.name == "" || profiletemp.surname == "" ? true : false)
                    
                }
            }
        }
        
    }
}

//struct AddProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddProfileView()
//    }
//}
