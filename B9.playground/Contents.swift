import Foundation

struct Unit {

    let baseAttack: Int
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
    var hp: Int {
        var (valueToAdd, newBaseValue) = Rune.valueToAdd(
            from: runes, of: .vital, to: baseHP
        )
        valueToAdd += Int(
            (Double(newBaseValue ?? baseHP) * (soulGearBuffs?.hp ?? 0.0)).rounded()
        )
        return baseHP + valueToAdd
    }

    struct SoulGearBuffs {
        let agility: Double
        let attack: Double
        let hp: Double
        static let maxedWarrior = SoulGearBuffs(agility: 0, attack: 0.1, hp: 0.1)
    }
    var soulGearBuffs: SoulGearBuffs?

}

let levia = Unit(
    baseAttack: 669, baseHP: 4444,
    runes: [sixStarVitalEpic, sixStarVitalEpicFlatSubstatVitalPercent],
    soulGearBuffs: nil
)

assert(levia.attack == 669)
assert(levia.hp == 9223)

let scarlet = Unit(
    baseAttack: 738, baseHP: 3115,
    runes: [fiveStarAssaultLegendFlat, fiveStarAssaultEpicFlatSubstatVitalPercent],
    soulGearBuffs: .maxedWarrior
)

assert(scarlet.attack == 1592)
assert(scarlet.hp == 3638)

struct Round {

}
