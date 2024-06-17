//
//  InfoPage.swift
//  Project
//
//  Created by 김소리 on 6/17/24.
//

import SwiftUI

struct InfoPage: View {
    @FocusState var isTextFieldFocused: Bool
    @State var nickname : String = ""
    @State var navigateToNextView = false
    @State var showAlert = false
    var body: some View {
        NavigationView(content: {
            VStack(content: {
                Text("안녕하세요 기웃기웃 입니다.")
                    .multilineTextAlignment(.center)
                    .padding(30)
                Text("사용하실 닉네임을 입력해주세요")
                    .padding(.bottom,20)
                
                TextField("", text: $nickname)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
                    .multilineTextAlignment(.leading)
                    .focused($isTextFieldFocused)
                    .padding(20)
                
                NavigationLink(destination: SelectView(), isActive: $navigateToNextView) {
                    Button("다음으로 가기") {
                        if !nickname.isEmpty {
                            Task {
                                await insertuserinfo(nickname: nickname)
                                navigateToNextView = true
                            }
                        } else {
                            showAlert = true
                        }
                    }
                    .alert("닉네임을 입력해주세요", isPresented: $showAlert, actions: {
                        Button("확인", role: .cancel) {}
                    })
                    .frame(width: 150,height: 40)
                    .background(Color(.black))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            })
        })
    }
    func insertuserinfo(nickname:String){
        let query = UserVM()
        let url = "http://127.0.0.1:5000/insertuserinfo?nickname=\(nickname)"
        Task {
            try await query.insertUserInfo(url:url)
        }
    }
}

#Preview {
    InfoPage()
}
