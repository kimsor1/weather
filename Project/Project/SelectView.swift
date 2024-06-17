//
//  SelectView.swift
//  Project
//
//  Created by 김소리 on 6/17/24.
//

import SwiftUI

struct SelectView: View {
    @State var navigateToNextView = false
    @State private var selectedOptions: [String] = [] // 사용자가 선택한 항목들을 담을 배열
    let options = ["패딩", "겨울코트", "경량패딩", "트렌치코트", "얇은코트", "가디건", "후드집업", "얇은가디건"] // 아우터 항목들
    
    var body: some View {
        NavigationStack{
            VStack(content: {
                Text("선택 항목:")
                    .bold()
                
                ForEach(options, id: \.self) { option in
                    SquareButton(selectedOptions: $selectedOptions, label: option)
                }
                
                Button("다음으로 가기") {
                    print(selectedOptions)
                    Task{
                        let query = ClothesVM()
                        try await query.insertOuter(outer: selectedOptions)
                    }
                    navigateToNextView = true
                }
                .navigationDestination(isPresented: $navigateToNextView) {
                    TopSelect()
                }
            })
        }
        .navigationBarBackButtonHidden(true) // 뒤로가기 버튼 숨기기
        .navigationBarHidden(true) // 네비게이션 바 숨기기
       
    }
    
    struct TopSelect: View {
        @State var navigateToNextView = false
        @State private var selectedOptions: [String] = []
        let options = ["민소매","반팔","얇은 긴팔","긴팔 티셔츠","후드티","맨투맨","니트"]
        
        var body: some View {
            VStack(content: {
                Text("선택 항목:")
                    .bold()
                
                ForEach(options, id: \.self) { option in
                    SquareButton(selectedOptions: $selectedOptions, label: option)
                }
                
                Button("다음으로 가기") {
                    print(selectedOptions)
                    Task{
                        let query = ClothesVM()
                        try await query.insertTop(top: selectedOptions)
                    }
                    navigateToNextView = true
                }
                .navigationDestination(isPresented: $navigateToNextView) {
                    BottomSelect()
                }
            })
        }
    }
    
    struct BottomSelect: View {
        @State var navigateToNextView = false
        @State private var selectedOptions: [String] = []
        let options = ["반바지", "면바지&청바지", "기모바지"]
        
        var body: some View {
            VStack(content: {
                Text("선택 항목 :")
                    .bold()
                
                ForEach(options,id : \.self) {option in
                    SquareButton(selectedOptions: $selectedOptions, label: option)
                }
                
                Button("다음으로 가기") {
                    print(selectedOptions)
                    Task{
                        let query = ClothesVM()
                        try await query.insertBottom(bottom: selectedOptions)
                    }
                    navigateToNextView = true
                }
                .navigationDestination(isPresented: $navigateToNextView) {
                    MainPage()
                }
                
            })
        }
    }
    
    struct SquareButton: View {
        @Binding var selectedOptions: [String]
        var label: String
        
        var body: some View {
            Button(action: {
                if selectedOptions.contains(label) { //선택항목배열에 label이 있을 때
                    selectedOptions.removeAll { $0 == label } // 배열에서 label 삭제
                } else { // 선택 항목배열에 label이 없을 때
                    selectedOptions.append(label) // 배열에 label 추가
                }
            }) {
                Text(label)
                    .padding()
                    .frame(width: 350)
                    .background(selectedOptions.contains(label) ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    SelectView()
}
