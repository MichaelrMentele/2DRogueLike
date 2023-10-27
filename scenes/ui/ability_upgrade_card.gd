extends PanelContainer

signal upgrade_selected

@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DescriptionLabel


func _ready() -> void:
	gui_input.connect(on_gui_input)


func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		upgrade_selected.emit()


func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description
