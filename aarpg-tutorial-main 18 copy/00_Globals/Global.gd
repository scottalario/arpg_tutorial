extends Node
### Global.gd


var hair_collection = {
	"01" : preload("res://Assets/hair/hair1.png"),
	"02" : preload("res://Assets/hair/hair2.png"),
	"03" : preload("res://Assets/hair/hair3.png"),
	"04" : preload("res://Assets/hair/hair4.png"),
	"05" : preload("res://Assets/hair/hair5.png"),
	
}

# Collection of outfit sprites
var outfit_collection = {
	"01" : preload("res://Assets/outfit/outfit1.png"),
	"02" : preload("res://Assets/outfit/outfit2.png"),
	"03" : preload("res://Assets/outfit/outfit3.png"),
	"04" : preload("res://Assets/outfit/outfit4.png"),
	"05" : preload("res://Assets/outfit/outfit5.png"),
	
}

# Collection of accessory sprites
var accessory_collection = {
	"none" : null,
	"01" : preload("res://Assets/accessories/acc1.png"),
	"02" : preload("res://Assets/accessories/acc2.png"),
	"03" : preload("res://Assets/accessories/acc3.png"),
	"04" : preload("res://Assets/accessories/acc4.png"),
	"05" : preload("res://Assets/accessories/acc5.png"),
	
}

var selected_hair = ""
var selected_outfit = ""
var selected_accessory = ""
