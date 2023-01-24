//
//  HomeView.swift
//  Suitable
//
//  Created by Martina Esposito on 19/01/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var SPMCViewModel = SendProfileMultipeerConnectivityViewModel()

    
    @StateObject var portfolio = profile1
    @StateObject var contacts = contacts1
    
    @State var showModalProfile = false
    @State var showModalContact = false
    @State var isShowDetailProfile = false
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.1)
    }
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(isShowDetailProfile ? .gray : .clear)
                    .ignoresSafeArea()
                    .opacity(isShowDetailProfile ? 0.8 : 1)
                
                VStack {
                    
                    if isShowDetailProfile {
                        DetailView(profile: portfolio.profiles[0], isShowDetail: $isShowDetailProfile)
                    } else {
                        
                        TabView{
                            
                                ForEach(portfolio.profiles) { profile in
                                    
                                    ProfileSliderItem(profile: profile, SPMCViewModel: SPMCViewModel, isShowDetailProfile: $isShowDetailProfile)
                                }
                            
                        }
                        .tabViewStyle(.page)
                        
                        
                            HStack (spacing: 10) {
                                
                                Text("Session")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                                
                                
                                if SPMCViewModel.connectedToSession {
                                    
                                    Text("\(SPMCViewModel.peers.count)/8 Joined")
                                        .font(.title3)
                                        .fontWeight(.light)
                                    
                                }
                            }
                            .padding(.horizontal)
                        
                        HostJoinView(SPMCViewModel: SPMCViewModel).padding(.vertical)
                    }
                    
                    
                    
                    makeLabel("Contacts")
                    
                    HStack{
                        
                        Text("RECENTS")
                            .foregroundColor(.secondary)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        Spacer()
                    }
                    
                    if #available(iOS 16.0, *) {
                        List{
                            ForEach(SPMCViewModel.profiles) { contact in
                                
                                ZStack{
                                    
                                    Color(isShowDetailProfile ? .gray : .clear)
                                        .opacity(isShowDetailProfile ? 0.1 : 1)
                                    
                                    ContactItem(contact: contact)
                                        .opacity(isShowDetailProfile ? 0.5 : 1)
                                }
                            }
                            //                        .onDelete { indexSet in
                            //                            contacts.contacts
                            //                                .remove(atOffsets: indexSet)
                            //
                            //                        }
                            .listRowBackground(Color.clear)
                        }
                        .scrollContentBackground(.hidden)
                        .disabled(isShowDetailProfile)
                    } else {
                        List{
                            ForEach(SPMCViewModel.profiles) { contact in
                                
                                ZStack{
                                    
                                    Color(isShowDetailProfile ? .gray : .clear)
                                        .opacity(isShowDetailProfile ? 0.1 : 1)
                                    
                                    ContactItem(contact: contact)
                                        .opacity(isShowDetailProfile ? 0.5 : 1)
                                }
                            }
                        }
                        .disabled(isShowDetailProfile)
                    }
                    
                    //                    Button(action: {
                    //                        showModalContact.toggle()
                    //                    }, label: {
                    //
                    //                        Text("Add Contact")
                    //
                    //                    })
                    //                    .buttonStyle(RoundedRectangleButtonStyle())
                    //                    .padding()
                    //                    .foregroundColor(.blue)
                    //                    .sheet(isPresented: $showModalContact, content: {
                    //
                    //                    })
                    
                    //                    Spacer()
                    
                }
            
            }
            .sheet(isPresented: $showModalProfile){
                
                AddProfileView(showsheet: $showModalProfile, portfolio: portfolio)
            }
            .navigationTitle("Resumes")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        showModalProfile.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            

//                .foregroundColor(isShowDetailProfile ? .gray : .clear)
//                .opacity(isShowDetailProfile ? 0.8 : 1)
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
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
    .background(Color("RedCustom"))
    .cornerRadius(8)
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}

struct ContactItem: View {
    
    let contact: Profile
    
        
    var body: some View {
        HStack{
            
            Image(contact.image )
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: 55,height: 55)
                .padding()
            
            Text(contact.name)
            Text(contact.surname)
            Spacer()
        }
                
    }
}


@ViewBuilder
func makeLabel(_ label : String) -> some View {
    HStack{
        Text(label)
            .font(.title)
            .fontWeight(.bold)
            .padding(.horizontal)
        Spacer()
    }
    
}

struct DetailView: View {
    
    var profile: Profile
    @Binding var isShowDetail: Bool
    
    var body: some View {
        
        ZStack(alignment: .topTrailing){
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 350, height:350)
                .foregroundColor(.white)
            
            VStack(alignment: .leading){


                    HStack{


                        Image("ImageProfile")
                                .resizable()
                                .scaledToFill()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .frame(width: 70,height: 70)
                                .padding()

                        VStack{

                            HStack{

                                Text(profile.role)
                                    .font(.title3)
                                    
                                Spacer()
                            }

                            HStack{
                                Text(profile.quote)
                                    .foregroundColor(.secondary)
                                    .fontWeight(.light)
                                    .italic()
//                                    .padding(.all, 0.5)
                                
                                Spacer()
                            }
                        }
                        .padding()

                    }
                
                if profile.tags!.isEmpty {
                    
                    Text(profile.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                } else {
                    
                    HStack{
                        ForEach(profile.tags!, id: \.self){ tag in

                            ZStack{
                                Rectangle()
                                    .frame(width: 90, height: 30)
                                    .foregroundColor(.blue)
                                    .opacity(0.2)
                                //                                    .border(.blue, width: 3)
                                Text(tag)
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.blue)

                            }
                            .cornerRadius(30)
                        }
                    }
                    .padding(.horizontal)
                    
                    Text(profile.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding()
                    
                }
            }

                
                HStack(alignment: .top){
                    Button{
                        isShowDetail.toggle()
                    } label: {
                        Image(systemName: "x.circle")
                            .font(.system(size: 30))
                            .padding()

                    }
                }
            
        }
        .frame(width: 350, height:350)
    }
}

