//
//  CaffeineCalcuator.swift
//  CapsuleTracker
//

class CaffeineCalcuator {
    private let coffeineAmountForDecaffInMiligramms = 5

    func calculateCaffeineAmount(isDecaff: Bool,
                                 with preparation: LogView.LogPreparationType) -> Int {
        guard !isDecaff else { return coffeineAmountForDecaffInMiligramms }
        switch preparation {
        case .espresso:
            return CapsulePreparation.espresso.amountOfCoffeineInMiligrams
        case .regular:
            return CapsulePreparation.regular.amountOfCoffeineInMiligrams
        }
    }
}
