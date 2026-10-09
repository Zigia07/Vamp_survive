extends CanvasLayer

signal upgrade_selected(upgrade: UpgradeData)

@onready var buttons: Array[Button] = [$Control/VBoxContainer/Button3, $Control/VBoxContainer/Button2, $Control/VBoxContainer/Button4,]

func show_choices(choices: Array[UpgradeData]):
	for i in range(buttons.size()):
		if i < choices.size():
			var upgrade = choices[i]
			buttons[i].text = upgrade.upgrade_name + "\n" + upgrade.description
			buttons[i].visible = true
			buttons[i].pressed.connect(func(): _on_choice_picked(upgrade), CONNECT_ONE_SHOT)
		else:
			buttons[i].visible = false
			
func _on_choice_picked(upgrade: UpgradeData):
	upgrade_selected.emit(upgrade)
	queue_free()
