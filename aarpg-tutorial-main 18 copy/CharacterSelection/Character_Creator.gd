### Character_Creator.gd

extends Node2D

const START_LEVEL : String = "res://Levels/Area01/02.tscn"

@export var music : AudioStream
@export var button_focus_audio : AudioStream
@export var button_press_audio : AudioStream

@onready var hair_collection: Button = $CanvasLayer/Control/Hair/CollectionButton
@onready var outfit_collection: Button = $CanvasLayer/Control/Outfit/CollectionButton
@onready var acc_collection: Button = $CanvasLayer/Control/Accessory/CollectionButton
@onready var confirm_button: Button = $CanvasLayer/Control/ConfirmButton
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer




func _ready() -> void:
	PlayerManager.player.visible = false
	PlayerHud.visible = false
	AudioManager.play_music( music )
	pass
	
func play_audio( _a : AudioStream ) -> void:
	audio_stream_player.stream = _a
	audio_stream_player.play()
	
	
	


func _on_confirm_button_pressed():
	
	
	PlayerManager.player.hair.texture=DressPlayer.hair_collection[DressPlayer.selected_hair]
	PlayerManager.player.outfit.texture=DressPlayer.outfit_collection[DressPlayer.selected_outfit]
	PlayerManager.player.accessory.texture=DressPlayer.accessory_collection[DressPlayer.selected_accessory]
	

	PlayerManager.player.visible = true
	PlayerHud.visible = true
	PauseMenu.process_mode = Node.PROCESS_MODE_ALWAYS
	
	LevelManager.load_new_level( START_LEVEL, "", Vector2.ZERO )
	
	pass
	
	
	
