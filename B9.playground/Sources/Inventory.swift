import Foundation

extension Rune {

    public static let sixStarFatalLegend = Rune(
        statType: .fatal, valueType: .percent, value: 0.5206, bonusOption: nil, split: nil
    ).validate()

    public static let sixStarRageLegend = Rune(
        statType: .rage, valueType: .percent, value: 1.354, bonusOption: nil, split: nil
    ).validate()

    public static let sixStarVitalEpic = Rune(
        statType: .vital, valueType: .percent, value: 0.5136, bonusOption: nil, split: nil
    ).validate()

    public static let sixStarVitalEpicFlatSubstatVitalPercent = Rune(
        statType: .vital, valueType: .flat, value: 1344,
        bonusOption: Rune.BonusOption(statType: .vital, valueType: .percent, value: 0.08), split: nil
    ).validate()

    public static let fiveStarAssaultLegendFlat = Rune(
        statType: .assault, valueType: .flat, value: 321, bonusOption: nil, split: nil
    ).validate()

    public static let fiveStarAssaultEpicFlatSubstatVitalPercent = Rune(
        statType: .assault, valueType: .percent, value: 0.4036,
        bonusOption: Rune.BonusOption(statType: .vital, valueType: .flat, value: 192), split: nil
    ).validate()

    public static let fiveStarShieldLegendSubstatFatal = Rune(
        statType: .shield, valueType: .percent, value: 0.2962,
        bonusOption: Rune.BonusOption(statType: .fatal, valueType: .percent, value: 0.064), split: nil
    ).validate()

}
