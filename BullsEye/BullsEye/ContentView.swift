//
//  ContentView.swift
//  BullsEye
//
//  Created by 居一龙夫人的mac on 2020/5/30.
//  Copyright © 2020 annyp. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible : Bool = false
    @State var sliderValue : Double = 50.0
    @State var target : Int = Int.random(in: 1...100)
    @State var score : Int = 0
    @State var round : Int = 1
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT BOld", size: 18))
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .modifier(Shadow())
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT BOld", size: 24))
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            // target row
            HStack {
                Text("Put the Bull's Eye as close as you can to:").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            
            Spacer()
            
            // slider row
            HStack {
                Text("1").modifier(ValueStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(midnightBlue)
                Text("100").modifier(ValueStyle())
            }
            
            Spacer()
            
            // bottom row
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/).modifier(LabelStyle())
            }
            .alert(isPresented: $alertIsVisible) {
                () -> Alert in
                return Alert(title: Text(self.alertTitle()),
                             message: Text("The slider's value is \(roundedVal(number: sliderValue)).\n" + "You scored \(self.pointsForCurrentRound()) scores for this round."),
                             dismissButton: .default(Text("Awesome!")) {
                                self.score += self.pointsForCurrentRound()
                                self.round += 1
                                self.target = Int.random(in: 1...100)
                    })
            }
            .background(Image("Button")).modifier(Shadow())
            
            
            Spacer()
            
            // score row
            HStack{
                Button(action: {
                    self.score = 0
                    self.round = 1
                    self.sliderValue = 50.0
                    self.target = Int.random(in: 1...100)
                }) {
                    HStack{
                        Image("StartOverIcon")
                        Text("Start Over").modifier(LabelStyle())
                    }
                }
                .background(Image("Button")).modifier(Shadow())
                Spacer()
                Text("Score: ").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: aboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info").modifier(LabelStyle())
                    }
                }
                .background(Image("Button")).modifier(Shadow())
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
        .navigationBarTitle("Bullseye")
    }
    
    func getDiff() -> Int {
        return abs(target - roundedVal(number: sliderValue))
    }
    
    func pointsForCurrentRound() -> Int {
        if getDiff() == 0 {
            return 200
        }
        return 100 - getDiff()
    }
    
    func roundedVal(number : Double) -> Int {
        return Int(number.rounded())
    }
    
    func alertTitle() -> String {
        let difference = getDiff()
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if (difference <= 10) {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
