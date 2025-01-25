### Outfit.gd

extends Node2D

# Node ref
@onready var outfit_sprite = $Sprite2D

# Keys
var outfit_keys = []

var current_outfit_index = 0


func _ready():
	set_sprite_keys()
	update_sprite()
	
# Set keys
func set_sprite_keys():
	outfit_keys = DressPlayer.outfit_collection.keys()

# Updates texture & modulate
func update_sprite():
	var current_sprite = outfit_keys[current_outfit_index]	
	outfit_sprite.texture = DressPlayer.outfit_collection[current_sprite]
	
	DressPlayer.selected_outfit = current_sprite
	
# Change outfit
func _on_collection_button_pressed():
	current_outfit_index = (current_outfit_index + 1) % outfit_keys.size()
	update_sprite()
