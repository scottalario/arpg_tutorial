extends Node

@onready var quest_advance_trigger: QuestAdvanceTrigger = $".."

func _ready() -> void:
		quest_advance_trigger.advanced.connect( quest_complete )
		
func quest_complete() -> void:
	PlayerManager.INVENTORY_DATA.use_item( load("res://Items/magical_flute.tres") )
pass
			
