//
//  ContentView.swift
//  Carousel_5
//
//  Created by Ivan Voznyi on 21.02.2024.
//

import SwiftUI

struct Card {
    let color: Color
    let title: String
}

struct ContentView: View {
    @State private var isCardTapped = false
    @State private var currentTripIndex = 0
    @GestureState private var dragOffset: CGFloat = 0
    let cards: [Card] = [
        Card(color: .black, title: "1"),
        Card(color: .red, title: "2"),
        Card(color: .green, title: "3"),
        Card(color: .yellow, title: "4"),
        Card(color: .accentColor, title: "5"),
        Card(color: .brown, title: "6"),
    ]
    
    var body: some View {
        ZStack {
            GeometryReader { outerView in
                HStack(spacing: 0) {
                    ForEach(cards.indices, id: \.self) { index in
                        GeometryReader { innerView in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(cards[index].color)
                                .overlay {
                                    Text(cards[index].title)
                                        .foregroundStyle(.white)
                                        .font(.system(size: 150))
                                }
                                .onTapGesture {
                                    withAnimation(.interpolatingSpring(.bouncy, initialVelocity: 0.3)) {
                                        isCardTapped = true
                                    }
                                }
                        }
                        .padding(.horizontal, isCardTapped ? 0 : 20)
                        .frame(width: outerView.size.width, height: currentTripIndex == index ? (isCardTapped ? outerView.size.height : 450) : 400)
                        .opacity(currentTripIndex == index ? 1.0 : 0.7)
                    }
                }
                .frame(width: outerView.size.width, height: outerView.size.height, alignment: .leading)
                .offset(x: -CGFloat(currentTripIndex) * outerView.size.width)
                .offset(x: dragOffset)
                .gesture(
                    !isCardTapped ?
                    DragGesture()
                        .updating($dragOffset, body: { (value, state, transaction) in
                            state = value.translation.width
                        })
                        .onEnded({ (value) in
                            let threshold = outerView.size.width * 0.65
                            var newIndex = Int(-value.translation.width/threshold) + currentTripIndex
                            newIndex = min(max(newIndex, 0), cards.count-1)
                            currentTripIndex = newIndex
                        })
                    : nil
                )
            }
            .animation(.interpolatingSpring(.bouncy), value: dragOffset)
            
            GeometryReader { geometry in
                if isCardTapped {
                    DetailView(title: cards[currentTripIndex].title, color: cards[currentTripIndex].color)
                        .padding(.top, geometry.safeAreaInsets  .top)
                        .transition(.move(edge: .bottom))
                        .ignoresSafeArea()
                    
                    Button(action: {
                        withAnimation {
                            isCardTapped = false
                        }
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(.white)
                            .opacity(0.7)
                            .contentShape(Rectangle())
                    })
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(.trailing)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
