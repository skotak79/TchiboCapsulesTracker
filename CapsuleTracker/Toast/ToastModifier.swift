import Foundation
import SwiftUI

struct SimpleToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            if isShowing {
                Text(text)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.brown.gradient)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    .padding()
                    .task {
                        try? await Task.sleep(nanoseconds: 2_000_000_000)
                        withAnimation {
                            isShowing.toggle()
                        }
                    }
            }
        }
    }
}

extension View {
    func simpleToast(isShowing: Binding<Bool>, text: String) -> some View {
        modifier(SimpleToastModifier(isShowing: isShowing, text: text))
    }
}

struct TestView2: View {
    @State var isShowing = false
    var body: some View {
        Button(action: {
            Task { @MainActor in
                withAnimation {
                    isShowing.toggle()
                }
            }
        }, label: {
            Text("Show toast")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
        .simpleToast(isShowing: $isShowing,
                     text: "Whatever, BlaBlaBla")
    }
}

#Preview(body: {
   TestView2()
})
