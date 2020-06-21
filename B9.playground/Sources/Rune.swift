import Foundation

protocol RuneLike {

    var statType: Rune.StatType { get set }
    var valueType: Rune.ValueType { get set }
    var value: Double { get set }

}

public struct Rune: RuneLike {

    public enum StatType {
        case assault, vital, fatal, rage, shield
    }
    var statType: StatType

    enum ValueType {
        case flat, percent
    }
    var valueType: ValueType

    var value: Double

    public struct BonusOption: RuneLike {
        var statType: StatType
        var valueType: ValueType
        var value: Double
    }
    let bonusOption: BonusOption?

    public static func valueToAdd(
        from allRunes: [Rune], of statType: StatType, to baseValue: Int
    ) -> (value: Int, newBaseValue: Int?) {
        var runeLikes = [RuneLike]()
        runeLikes += allRunes.filter { $0.statType == statType } as [RuneLike]
        runeLikes += allRunes.compactMap { $0.bonusOption }.filter { $0.statType == statType } as [RuneLike]
        var value: Double = 0
        value += runeLikes.filter { $0.valueType == .flat }.reduce(0) { $0 + $1.value }
        let newBaseValue: Int? = (value > 0) ? (baseValue + Int(value)) : nil
        value += (Double(baseValue) + value) *
            runeLikes.filter { $0.valueType == .percent }.reduce(0) { $0 + $1.value }
        return (Int(value), newBaseValue)
    }

}
