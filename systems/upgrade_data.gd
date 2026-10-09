extends Resource
class_name UpgradeData

enum Stat {DAMAGE, SPEED, MAX_HP, COOLDOWN, AOE}

@export var upgrade_name: String = ""
@export var description: String = ""
@export var stat: Stat
@export var amount: float = 0.0
