//
//  aboutView.swift
//  BullsEye
//
//  Created by 居一龙夫人的mac on 2020/6/1.
//  Copyright © 2020 annyp. All rights reserved.
//

import SwiftUI

struct aboutView: View {
    var body: some View {
        VStack {
            Text("🎯 Bullseye 🎯")
            Text("This is Bullseye, the game where you can win points and earn fame")
        }
        .navigationBarTitle("About Bullseye")
    }
}

struct aboutView_Previews: PreviewProvider {
    static var previews: some View {
        aboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
