import Foundation

protocol RuneLike {

    var statType: Rune.StatType { get set }
    var valueType: Rune.ValueType { get set }
    var value: Double { get set }

}

public struct Rune: RuneLike {

    public enum StatType {
        case assault, vital, fatal, rage, shield
        func supports(valueType: ValueType) -> Bool {
            guard valueType == .flat else { return true }
            return self == .fatal || self == .rage || self == .shield
        }
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

    public func validate() -> Rune {
        assert(statType.supports(valueType: valueType))
        return self
    }

    public static func valueToAdd(
        from allRunes: [Rune], of statType: StatType, to baseValue: Int
    ) -> (value: Int, newBaseValue: Int?) {
        let runeLikes = self.runeLikes(from: allRunes, of: statType)
        var value: Double = 0
        value += runeLikes.filter { $0.valueType == .flat }.reduce(0) { $0 + $1.value }
        let newBaseValue: Int? = (value > 0) ? (baseValue + Int(value)) : nil
        value += (Double(baseValue) + value) *
            runeLikes.filter { $0.valueType == .percent }.reduce(0) { $0 + $1.value }
        return (Int(value), newBaseValue)
    }

    static func runeLikes(from allRunes: [Rune], of statType: StatType) -> [RuneLike] {
        var runeLikes = [RuneLike]()
        runeLikes += allRunes.filter { $0.statType == statType } as [RuneLike]
        runeLikes += allRunes.compactMap { $0.bonusOption }.filter { $0.statType == statType } as [RuneLike]
        return runeLikes
    }

}
