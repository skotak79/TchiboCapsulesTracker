import SwiftUI

struct RowView: View {
    let container: CapsuleContainer
    var descriptionPluralized: String {
        container.quantity > 1 ? "capsules" : "capsule"
    }
    var body: some View {

        return HStack {
            Image(container.capsule.capsuleImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            Text(container.capsule.name)
                .font(.system(size: 18))
               .fontWeight(.semibold)
                .lineLimit(2)
            if container.owned {
                Spacer()
                VStack {
                    Text("\(container.quantity)")
                        .fontDesign(.monospaced)
                        .foregroundStyle(.brown)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }

    }
}

#Preview("RowView") {
    let container = CapsuleContainer(
        capsule: CapsuleModel.decaff,
        quantity: 1)
    return RowView(container: container)
}
#Preview("List") {
    let all = CapsuleModel.all.map { CapsuleContainer(
        capsule: $0,
        quantity: 1)
    }
    return List(all) { container in
        RowView(container: container)
            .listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 12))
    }
    .listStyle(.plain)
}
