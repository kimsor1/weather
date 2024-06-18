//
//  SplashView.swift
//  Project
//
//  Created by 김소리 on 6/15/24.
//

import SwiftUI

struct SplashView: View {
    @State private var showMainView = false
    @State private var imageScale: CGFloat = 1.0
    @State private var imageOpacity: Double = 1.0
    @State private var imageRotation: Double = 0.0
    
    @State var nickname = ""

    
    var body: some View {
        ZStack {
            if showMainView{
                if nickname == ""{
                    InfoPage()
                }
                else{
                    MainPage()
                }
            }
            else {
                SplashContentView(imageScale: $imageScale, imageOpacity: $imageOpacity, imageRotation: $imageRotation)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.easeInOut(duration: 2.0)) {
                                imageScale = 5.0
                                imageOpacity = 0.0
                                imageRotation = 360.0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation {
                                    showMainView = true
                                }
                            }
                        }
                    }
            }
        }
        .onAppear{
            finduser()
        }
    }
    func finduser(){
        let query = UserVM()
        nickname = query.queryDB()
    }
}


struct SplashContentView: View {
    @Binding var imageScale: CGFloat
    @Binding var imageOpacity: Double
    @Binding var imageRotation: Double
    
    var body: some View {
        ZStack {
            VStack {
                Image("icon")
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                    .scaleEffect(imageScale)
                    .opacity(imageOpacity)
                    .rotationEffect(.degrees(imageRotation))
            }
        }
    }
}

struct WelcomeView : View{
    var body: some View {
        Text("안녕하세요")
    }
}

#Preview {
    SplashView()
}
