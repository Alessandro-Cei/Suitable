//
//  HomeView.swift
//  Suitable
//
//  Created by Martina Esposito on 19/01/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var portfolio = profile1
    @StateObject var contacts = contacts1
    
    @State var showModalProfile = false
    @State var showModalContact = false
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.1)
    }
    
    
    var body: some View {
            NavigationView{
                VStack {
                    TabView{
                        
                        if portfolio.profiles.count > 0{
                            ForEach(portfolio.profiles) { profile in
                                
                                ProfileSliderItem(profile: profile)
                            }
                        } else {
                            ProfileSliderItem(profile: nil)
                        }
                        
                    }
                    .tabViewStyle(.page)
                    
                    HStack{
                        Text("Contacts")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        Spacer()
                    }
                    
                    List{
                        
                        ForEach(contacts.contacts) { contact in
                            
                            NavigationLink{
                                
                            } label: {
                                ContactItem(contact: contact)
                            }
                        }
                        .onDelete { indexSet in
                            contacts.contacts
                                .remove(atOffsets: indexSet)

                        }
                    }
                    .scrollContentBackground(.hidden)
                    
                    Button(action: {
                        showModalContact.toggle()
                    }, label: {
                         
                        Text("Add Contact")
                        
                    })
                    .buttonStyle(RoundedRectangleButtonStyle())
                    .padding()
                    .foregroundColor(.blue)
                    .sheet(isPresented: $showModalContact, content: {
                        
                    })
                    
                    
                }
                .sheet(isPresented: $showModalProfile){
                    
                    AddProfileView(showsheet: $showModalProfile, portfolio: portfolio)
                }
                .navigationTitle("My Portfolio")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button{
                            showModalProfile.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct ProfileSliderItem: View {
    
    let profile: Profile?
    
        
    var body: some View {
        ZStack(alignment: .topLeading){
            Rectangle()
                .frame(width: 350, height: 200)
                .foregroundColor(.blue)
                .opacity(0.1)
            
            VStack(alignment: .leading){
                
                HStack{
                    
                    
                        Image(systemName: "person.circle")
                            .resizable()
        //                    .scaledToFill()
                            .foregroundColor(profile != nil ? .blue : .secondary)
                            .font(Font.system(size: 100, weight: .light))
                            .frame(width: 45,height: 45)
                            .padding()
                    
                    HStack{
                        
                        Text(profile?.name ?? "No Profile")
                            .font(.title3)
                            .lineLimit(3)
                            .foregroundColor(profile != nil ? .black : .secondary)
                        
                        Text(profile?.surname ?? "")
                            .font(.title3)
                            .lineLimit(3)
                            .foregroundColor(profile != nil ? .black : .secondary)
                    }
                    
                }
                
//                if profile != nil{
                    
                    Button(action: {
                        
                    }, label: {
                         
                        Text("Send")
                        
                    })
                    .buttonStyle(RoundedRectangleButtonStyle())
                    .padding()
                    .foregroundColor(.blue)
                    .frame(width: 150)
//                }
                
                
                
//                if profile != nil {
//
//                    HStack{
//                        ForEach(profile!.links, id: \.self) { link in
//                            ZStack{
//                                Rectangle()
//                                    .frame(height: 30)
//                                    .foregroundColor(.blue)
//                                    .opacity(0.3)
//                                Text("\(link)")
//                                    .font(.callout)
//                                    .multilineTextAlignment(.leading)
//                            }
//                            .frame(maxWidth: 100)
//                        }
//                        .cornerRadius(10)
//                    }
//                    .lineLimit(1)
//                    .padding(.horizontal)
//
//    //                        Text(profile.description)
//    //                            .font(.title3)
//    //                            .lineLimit(3)
//    //                            .padding(.horizontal)
//
//                    HStack{
//                        if profile!.tags.count <= 3 {
//
//                            ForEach(profile!.tags, id: \.self) { tag in
//                                ZStack{
//                                    Rectangle()
//                                        .frame(height: 30)
//                                        .foregroundColor(.blue)
//                                        .opacity(0.3)
//                                    Text(tag)
//                                        .font(.callout)
//                                        .multilineTextAlignment(.leading)
//
//                                }
//                                .frame(maxWidth: 80)
//                                .cornerRadius(10)
//                            }
//
//                        } else {
//
//                            ForEach(0...3, id: \.self) { i in
//                                ZStack{
//                                    Rectangle()
//                                        .frame(height: 30)
//                                        .foregroundColor(.blue)
//                                        .opacity(0.3)
//                                    Text(profile!.tags[i])
//                                        .font(.callout)
//                                        .multilineTextAlignment(.leading)
//
//                                }
//                                .cornerRadius(10)
//                            }
//                        }
//                    }
//                    .padding(.horizontal)
//                    .lineLimit(1)
//                }
                
            }
            
        }
        .cornerRadius(20)
        .padding(.bottom, 40)
        .frame(width: 350, height: 200)

    }
}


struct RoundedRectangleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Spacer()
      configuration.label.foregroundColor(.white)
      Spacer()
    }
    .padding()
    .background(Color.accentColor)
    .cornerRadius(8)
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}

struct ContactItem: View {
    
    let contact: Profile
    
        
    var body: some View {
        HStack{
            Text(contact.name)
            Text(contact.surname)
        }
                
    }
}
