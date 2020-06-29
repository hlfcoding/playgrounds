import Foundation

/// A rune-like object can buff a unit's stat.
protocol RuneLike {

    /// The main type that determines the stat.
    var statType: Rune.StatType { get set }
    /// The secondary type, possibly limited by the main type.
    var valueType: Rune.ValueType { get set }
    /// The value of the buff.
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

    /// Runes can (optionally) have a bonus option, which buffs a unit's stat like a rune.
    /// However both statType and valueType cannot be the same as the rune, though this isn't validated.
    public struct BonusOption: RuneLike {
        var statType: StatType
        var valueType: ValueType
        var value: Double
    }
    let bonusOption: BonusOption?

    /// Chain after initialization to test assumptions.
    public func validate() -> Rune {
        assert(statType.supports(valueType: valueType))
        return self
    }

    /// Calculates the buff to add for a stat-type that supports both value-types.
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

    /// Calculates the buff to add for a stat-type that supports only percent value-type.
    public static func valueToAdd(
        from allRunes: [Rune], of statType: StatType, to baseValue: Double
    ) -> Double {
        let runeLikes = self.runeLikes(from: allRunes, of: statType)
        var value: Double = 0
        value += runeLikes.filter { $0.valueType == .percent }.reduce(0) { $0 + $1.value }
        return value
    }

    static func runeLikes(from allRunes: [Rune], of statType: StatType) -> [RuneLike] {
        var runeLikes = [RuneLike]()
        runeLikes += allRunes.filter { $0.statType == statType } as [RuneLike]
        runeLikes += allRunes.compactMap { $0.bonusOption }.filter { $0.statType == statType } as [RuneLike]
        return runeLikes
    }

}
