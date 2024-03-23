//
//  DetailView.swift
//  Carousel_5
//
//  Created by Ivan Voznyi on 21.02.2024.
//

import SwiftUI

struct DetailView: View {
    let title: String
    let color: Color
    
    @State var items = 3...Int.random(in: 3...10)
    
    var body: some View {
        ZStack {
            Color(color)
                .ignoresSafeArea()
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.system(size: 50, design: .rounded))
                        .fontWeight(.heavy)
                        .padding(.leading, 20)
                        .foregroundStyle(.white)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(items, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 4)
                                .fill(.white)
                                .frame(width: CGFloat(Int.random(in: 200...Int(geometry.size.width - 25))), height: 30)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        }
                    }.padding()
                }
            }
        }
    }
}

#Preview {
    DetailView(title: "1", color: .yellow)
}
