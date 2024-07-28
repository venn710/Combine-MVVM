//
//  TodoCard.swift
//  Combine+MVVM
//
//  Created by Venkatesham Boddula on 28/07/24.
//

import SwiftUI

struct TodoCard: View {
    let data: ToDo
    var body: some View {
        HStack {
            Text(data.title)
            Spacer()
            Group {
                if data.completed {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .foregroundStyle(Color(uiColor: .systemGreen))
                } else {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundStyle(Color(uiColor: .systemRed))
                    
                }
            }
            .frame(width: 24, height: 24)
            .scaledToFit()
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
