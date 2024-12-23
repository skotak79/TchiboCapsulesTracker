//
//  HealthKitAuthorizedInfo.swift
//  CapsuleTracker
//

import SwiftUI

struct HealthKitAuthorizedInfo: View {
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(.iconAppleHealth)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 44, maxHeight: 44)

            VStack(alignment: .leading) {
                Text("Apple Health")
                    .font(.headline)
                Text("The Amount of caffene will be recorded to Apple Health app")
                    .font(.footnote)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 8)
            .foregroundStyle(Gradient(colors: [.green.opacity(0.9), Color.green.opacity(0.7)])))
    }
}

#Preview {
    VStack {
        HealthKitAuthorizedInfo()
        HealthAuthorizationButton {
           print("Allow tapped")
        }
    }
    .padding(.horizontal, 12)
}
