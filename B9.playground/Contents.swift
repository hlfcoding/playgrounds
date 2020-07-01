import Foundation

struct Unit {

    let baseAttack: Int
    let baseCritDamage: Double
    let baseCritRate: Double
    let baseDefense: Double
    let baseHP: Int
    var runes: [Rune]

    var attack: Int {
        var (valueToAdd, newBaseValue) = Rune.valueToAdd(
            from: runes, of: .assault, to: baseAttack
        )
        valueToAdd += Int(
            (Double(newBaseValue ?? baseAttack) * (soulGearBuffs?.attack ?? 0.0)).rounded()
        )
        return baseAttack + valueToAdd
    }
    var critDamage: Double {
        let valueToAdd = Rune.valueToAdd(from: runes, of: .rage, to: baseCritDamage)
        return baseCritDamage + valueToAdd
    }
    var critRate: Double {
        let valueToAdd = Rune.valueToAdd(from: runes, of: .fatal, to: baseCritRate)
        return baseCritRate + valueToAdd
    }
    var defense: Double {
        let valueToAdd = Rune.valueToAdd(from: runes, of: .shield, to: baseDefense)
        return baseDefense + valueToAdd
    }
    var hp: Int {
        var (valueToAdd, newBaseValue) = Rune.valueToAdd(
            from: runes, of: .vital, to: baseHP
        )
        valueToAdd += Int(
            (Double(newBaseValue ?? baseHP) * (soulGearBuffs?.hp ?? 0.0)).rounded()
        )
        return baseHP + valueToAdd
    }

    var normalAttack: Int {
        let critRoll = Double.random(in: 0...1)
        let critRollDamage = (critRoll <= critRate) ? critDamage : 0
        return Int(Double(attack) * (1 + critRollDamage).rounded())
    }

    struct SoulGearBuffs {
        let agility: Double
        let attack: Double
        let hp: Double
        static let maxedWarrior = SoulGearBuffs(agility: 0, attack: 0.1, hp: 0.1)
    }
    var soulGearBuffs: SoulGearBuffs?

    func validate(
        attack: Int? = nil, critDamage: Double? = nil, critRate: Double? = nil,
        defense: Double? = nil, hp: Int? = nil,
        normalAttack: ClosedRange<Int>? = nil
    ) -> Unit {
        if let attack = attack { assert(self.attack == attack) }
        if let critDamage = critDamage { assert(self.critDamage == critDamage) }
        if let critRate = critRate { assert(self.critRate == critRate) }
        if let defense = defense { assert(self.defense == defense) }
        if let hp = hp { assert(self.hp == hp) }
        if let range = normalAttack { assert(range.contains(self.normalAttack)) }
        return self
    }

}

extension Unit {

    static let angelica = Unit(
        baseAttack: 1975, baseCritDamage: 1, baseCritRate: 0.25, baseDefense: 0.1, baseHP: 4285,
        runes: [.sixStarFatalLegend, .fiveStarShieldLegendSubstatFatal],
        soulGearBuffs: .maxedWarrior
    ).validate(
        attack: 2173, critRate: 0.8346, defense: 0.3962, hp: 4714, normalAttack: 2173...4346
    )

    static let levia = Unit(
        baseAttack: 669, baseCritDamage: 0.5, baseCritRate: 0.2, baseDefense: 0, baseHP: 4444,
        runes: [.sixStarVitalEpic, .sixStarVitalEpicFlatSubstatVitalPercent],
        soulGearBuffs: nil
    ).validate(attack: 669, hp: 9223)

    static let scarlet = Unit(
        baseAttack: 738, baseCritDamage: 0.75, baseCritRate: 0.35, baseDefense: 0.05, baseHP: 3115,
        runes: [.fiveStarAssaultLegendFlat, .fiveStarAssaultEpicFlatSubstatVitalPercent],
        soulGearBuffs: .maxedWarrior
    ).validate(attack: 1592, hp: 3638)

}

var subject = Unit.angelica
subject.runes[0] = .sixStarRageLegend
print(subject.normalAttack)

struct Round {

}
