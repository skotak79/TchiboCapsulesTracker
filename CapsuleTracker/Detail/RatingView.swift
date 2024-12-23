import SwiftUI

struct RatingView: View {
    let rating: FeatureRating
    var body: some View {
        HStack {
            RatingCircleView(isFilled: rating >= .one)
            RatingCircleView(isFilled: rating >= .two)
            RatingCircleView(isFilled: rating >= .three)
            RatingCircleView(isFilled: rating >= .four)
            RatingCircleView(isFilled: rating >= .five)
            RatingCircleView(isFilled: rating >= .six)
        }
    }
}

#Preview("One", traits: .sizeThatFitsLayout) {
    RatingView(rating: .one)
}

#Preview("Two", traits: .sizeThatFitsLayout) {
    RatingView(rating: .two)
}

#Preview("Three", traits: .sizeThatFitsLayout) {
    RatingView(rating: .three)
}

#Preview("Four", traits: .sizeThatFitsLayout) {
    RatingView(rating: .four)
}

#Preview("Five", traits: .sizeThatFitsLayout) {
    RatingView(rating: .five)
}

#Preview("Six", traits: .sizeThatFitsLayout) {
    RatingView(rating: .six)
}

private struct RatingCircleView: View {
    let isFilled: Bool
    var body: some View {
        Image(systemName: "circle.fill")
            .foregroundStyle(isFilled ? .primary : .tertiary)
    }
}
