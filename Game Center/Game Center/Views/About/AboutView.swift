//
//  AboutView.swift
//  Game Center
//
//  Created by Dicoding Reviewer on 20/08/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image("photo")
                .resizable()
                .clipShape(Circle())
                .frame(maxWidth: 200, maxHeight: 200)
            
            Text("Deden Muhamad Furqon")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(ColorManager.primaryTextColor)
            
            Text("furqoncreative24@gmail.com")
                .font(.system(size: 14, weight: .regular, design: .default))
                .foregroundColor(ColorManager.primaryTextColor)
                .padding(.top, 1)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .top
          )
        .padding()
        .navigationBarTitle(Text("About"), displayMode: .inline)
        .background(ColorManager.backgroundColor)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
