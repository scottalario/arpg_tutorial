### Accessory.gd

extends Node2D

# Node ref
@onready var accessory_sprite = $Sprite2D

# Keys
var accessory_keys = []

var current_accessory_index = 0


func _ready():
	set_sprite_keys()
	update_sprite()
	
# Set keys
func set_sprite_keys():
	accessory_keys = DressPlayer.accessory_collection.keys()

# Updates texture & modulate
func update_sprite():
	var current_sprite = accessory_keys[current_accessory_index]	
	if current_sprite == "none":
		accessory_sprite.texture = null
	else:
		accessory_sprite.texture = DressPlayer.accessory_collection[current_sprite]
		
	
	DressPlayer.selected_accessory = current_sprite
	

# Change accessory
func _on_collection_button_pressed():
	current_accessory_index = (current_accessory_index + 1) % accessory_keys.size()
	update_sprite()
