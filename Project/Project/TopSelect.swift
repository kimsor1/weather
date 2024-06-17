//
//  TopSelect.swift
//  Project
//
//  Created by 김소리 on 6/13/24.
//

import SwiftUI

struct TopSelect: View {
    
    @State private var selectedOptions: [String] = []
    let options = ["민소매","반팔","얇은 긴팔","긴팔 티셔츠","후드티","맨투맨","니트"]
    
    var body: some View {
        VStack(content: {
            Text("선택 항목:")
                .bold()
            
            ForEach(options, id: \.self) { option in
                SquareButton(selectedOptions: $selectedOptions, label: option)
            }
        })
    }
    
    
    struct SquareButton: View {
        @Binding var selectedOptions: [String]
        var label: String
        
        var body: some View {
            Button(action: {
                if selectedOptions.contains(label) {
                    selectedOptions.removeAll { $0 == label }
                } else {
                    selectedOptions.append(label)
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
    TopSelect()
}
