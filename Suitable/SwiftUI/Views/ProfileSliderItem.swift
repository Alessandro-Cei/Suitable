//
//  ProfileSliderItem.swift
//  Suitable
//
//  Created by Ale on 24/01/23.
//

import Foundation
import SwiftUI

struct ProfileSliderItem: View {
    
    let profile: Profile
    @ObservedObject var SPMCViewModel: SendProfileMultipeerConnectivityViewModel
    @Binding var isShowDetailProfile: Bool
    
        
    var body: some View {
        ZStack(alignment: .topLeading){
            RoundedRectangle(cornerRadius: 20)
                .padding()
                .foregroundColor(.gray)
                .opacity(0.1)
            VStack {
                
                HStack {
                    createImage(profile: profile) //TODO: - This should just pass the image
                    
                    createRoleAndQuoteLabel(quote: profile.quote, role: profile.role)
                }
                
                if !profile.tags!.isEmpty {
                    createTagsLabel(tags: profile.tags!)
                }
                
                createButtons(profile: profile, SPMCViewModel: _SPMCViewModel)
            }
        }
    }
}

@ViewBuilder
func createRoleAndQuoteLabel (quote: String, role: String) -> some View {
    VStack {
        HStack {
            Text(role)
                .font(.title)
                .frame(alignment: .leading)
            Spacer()
        }
        
        HStack {
            Text(quote)
                .lineLimit(2)
                .minimumScaleFactor(0.6)
                .multilineTextAlignment(.leading)
                .font(Font.system(size: 16).italic())
                .foregroundColor(.secondary)
            Spacer()
        }
        
    }.padding([.top, .trailing], Settings.padding).padding(.leading)

}

@ViewBuilder
func createTagsLabel (tags: [String]) -> some View {
    HStack {
        ForEach(tags, id:  \.self) { tag in
            ZStack {
                HStack (spacing: 0) {
                    Text("#")
                    Text(tag.description)
                }.foregroundColor(.blue)
                
                    .padding(.vertical, 7)
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(.blue, lineWidth: 2.5)
                        RoundedRectangle(cornerRadius: 100)
                            .foregroundColor(.teal).opacity(0.1)
                    }
            }
        }
    }
}

@ViewBuilder
func createButtons (profile : Profile, SPMCViewModel : ObservedObject<SendProfileMultipeerConnectivityViewModel>) -> some View {
    HStack {
        Button(action: {
            //TODO: - Fare una view profilo
            //                        isShowDetailProfile.toggle()
        }, label: {
            Text("See All")
                .font(.title3)
                .underline(true)
                .foregroundColor(.pink)
        })
        
        Spacer()
        
        Button(action: {
            SPMCViewModel.wrappedValue.send(profile: profile)
//            SPMCViewModel.send(profile: profile)
        }, label: {
            Text("Share")
                .font(.title3)
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal, Settings.smallPadding)
                .background {
                    RoundedRectangle(cornerRadius: Settings.cornerRadius)
                        .foregroundColor(.pink)
                }
        })
    }.padding([.horizontal, .bottom], Settings.padding).padding(.top, Settings.smallPadding)
}

@ViewBuilder
func createImage (profile : Profile) -> some View {
    Image(profile.image)
        .resizable()
        .frame(width: Settings.imageSize, height: Settings.imageSize)
        .clipShape(RoundedRectangle(cornerRadius: Settings.cornerRadius))
        .padding([.leading, .top], Settings.padding)

}

struct Settings {
    static var padding : CGFloat = 30
    static var smallPadding : CGFloat = 10
    static var cornerRadius : CGFloat = 10
    static var imageSize : CGFloat = 70
}
