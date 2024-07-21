//
//  TopNavigationView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

import SwiftUI

struct TopNavigationView: View {
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("My Kidney")
                    .font(.headline)
            }
            
            Spacer()
            
            Button(action: {print("To Search")}) {
                ZStack(alignment: .topTrailing){
                    Image(systemName: "bell")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text("5")
                        .frame(width: 10, height: 10)
                        .padding(.all, 3)
                        .background(Color.red)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(Color.white)
                        .font(.caption2)
                        .bold()
                        .padding(.top, -5)
                        .padding(.trailing, -5)
                }
            }
            .foregroundStyle(Color.black)
            
            Button(action: {
                
            }) {
                Image(systemName: "list.bullet")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .bold()
            }
            .foregroundStyle(Color.black)
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    TopNavigationView()
}
