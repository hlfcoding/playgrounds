import Foundation

struct Unit {

    let baseAttack: Int
    let baseCritDamage: Double
    let baseCritRate: Double
    let baseDefense: Double
    let baseHP: Int
    let runes: [Rune]

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
        return Int(Double(attack) * (1 + (critRate * critDamage)).rounded())
    }

    struct SoulGearBuffs {
        let agility: Double
        let attack: Double
        let hp: Double
        static let maxedWarrior = SoulGearBuffs(agility: 0, attack: 0.1, hp: 0.1)
    }
    var soulGearBuffs: SoulGearBuffs?

}

extension Unit {

    static let angelica = Unit(
        baseAttack: 1975, baseCritDamage: 1, baseCritRate: 0.25, baseDefense: 0.1, baseHP: 4285,
        runes: [.sixStarFatalLegend, .fiveStarShieldLegendSubstatFatal],
        soulGearBuffs: .maxedWarrior
    )

    static let levia = Unit(
        baseAttack: 669, baseCritDamage: 0.5, baseCritRate: 0.2, baseDefense: 0, baseHP: 4444,
        runes: [.sixStarVitalEpic, .sixStarVitalEpicFlatSubstatVitalPercent],
        soulGearBuffs: nil
    )

    static let scarlet = Unit(
        baseAttack: 738, baseCritDamage: 0.75, baseCritRate: 0.35, baseDefense: 0.05, baseHP: 3115,
        runes: [.fiveStarAssaultLegendFlat, .fiveStarAssaultEpicFlatSubstatVitalPercent],
        soulGearBuffs: .maxedWarrior
    )

}

assert(Unit.levia.attack == 669)
assert(Unit.levia.hp == 9223)

assert(Unit.scarlet.attack == 1592)
assert(Unit.scarlet.hp == 3638)

assert(Unit.angelica.attack == 2173)
assert(Unit.angelica.critRate == 0.8346)
assert(Unit.angelica.defense == 0.3962)
assert(Unit.angelica.hp == 4714)

var subject = Unit.angelica
print(Unit.angelica.normalAttack)

struct Round {

}
