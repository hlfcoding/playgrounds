import Foundation

public let sixStarVitalEpic = Rune(
    statType: .vital, valueType: .percent, value: 0.5136, bonusOption: nil
).validate()

public let sixStarVitalEpicFlatSubstatVitalPercent = Rune(
    statType: .vital, valueType: .flat, value: 1344,
    bonusOption: Rune.BonusOption(statType: .vital, valueType: .percent, value: 0.08)
).validate()

public let fiveStarAssaultLegendFlat = Rune(
    statType: .assault, valueType: .flat, value: 321, bonusOption: nil
).validate()

public let fiveStarAssaultEpicFlatSubstatVitalPercent = Rune(
    statType: .assault, valueType: .percent, value: 0.4036,
    bonusOption: Rune.BonusOption(statType: .vital, valueType: .flat, value: 192)
).validate()
