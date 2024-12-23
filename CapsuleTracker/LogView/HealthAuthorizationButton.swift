//
//  HealthAuthorizationButton.swift
//  CapsuleTracker
//

import Foundation
import SwiftUI

struct HealthAuthorizationButton: View {
    let action: () -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
                Image(systemName: "heart.text.square.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 44, maxHeight: 44)
                VStack(alignment: .leading) {
                    Text("Record to Apple Health")
                        .font(.headline)
                    Text("Record the amount of caffeine to the Apple Health app.")
                        .font(.footnote)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding([.leading, .trailing, .top], 12)

            Button(action: {
                action()
            }, label: {
                Text("Allow")
                    .frame(maxWidth: .infinity)
                    .bold()
            })
            .padding([.leading, .trailing, .bottom], 12)
            .buttonStyle(.borderedProminent)
        }
        .background(RoundedRectangle(cornerRadius: 8)
            .foregroundStyle(.quaternary)
        )
    }
}
