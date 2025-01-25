class_name Player extends CharacterBody2D

signal direction_changed( new_direction: Vector2 )
signal player_damaged( hurt_box: HurtBox )

const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player : AnimationPlayer = $EffectAnimationPlayer
@onready var hit_box : HitBox = $HitBox
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine
@onready var audio: AudioStreamPlayer2D = $Audio/AudioStreamPlayer2D
@onready var lift: State_Lift = $StateMachine/Lift
@onready var held_item: Node2D = $Sprite2D/HeldItem
@onready var carry: State_Carry = $StateMachine/Carry
@onready var hair : Sprite2D = $Sprite2D/Style/Hair
@onready var outfit : Sprite2D = $Sprite2D/Style/Outfit
@onready var accessory : Sprite2D = $Sprite2D/Style/Accessory

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

var invulnerable : bool = false
var hp : int = 6
var max_hp : int = 6

var level : int = 1
var xp : int = 0

var attack : int = 1 :
	set( v ):
		attack = v
		update_damage_values()
		
var defense : int = 1




# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerManager.player = self
	#dress_player()
	state_machine.Initialize(self)
	hit_box.damaged.connect( _take_damage )
	update_hp(99)
	update_damage_values()
	PlayerManager.player_leveled_up.connect( _on_player_leveled_up )
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( _delta ):
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	pass


func _physics_process( _delta ):
	move_and_slide()



func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("test"):
		#PlayerManager.shake_camera()
	pass



func set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int( round( ( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_4.size() ) )
	var new_dir = DIR_4[ direction_id ]
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	direction_changed.emit( new_dir )
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func dress_player(): 
	outfit.texture = DressPlayer.outfit_collection[DressPlayer.selected_outfit]
	accessory.texture = DressPlayer.accessory_collection[DressPlayer.selected_accessory]
	
	
	

func update_animation( state : String ) -> void:
	animation_player.play( state + "_" + anim_direction() )
	pass


func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"



func _take_damage( hurt_box : HurtBox ) -> void:
	if invulnerable == true:
		return
	
	if hp > 0:
		var dmg : int = hurt_box.damage 
		if dmg > 0: 
			dmg = clampi( dmg - defense, 1, dmg )
		
		update_hp( -dmg )
		player_damaged.emit( hurt_box )
		
	
	pass


func update_hp( delta : int ) -> void:
	hp = clampi( hp + delta, 0, max_hp )
	PlayerHud.update_hp( hp, max_hp )
	pass


func make_invulnerable( _duration : float = 1.0 ) -> void:
	invulnerable = true
	hit_box.monitoring = false
	
	await get_tree().create_timer( _duration ).timeout
	
	invulnerable = false
	hit_box.monitoring = true
	pass


func pickup_item( _t : Throwable ) -> void:
	state_machine.change_state( lift )
	carry.throwable = _t
	pass



func revive_player() -> void:
	update_hp( 99 )
	state_machine.change_state( $StateMachine/Idle )

func update_damage_values() -> void:
	%AttackHurtBox.damage = attack
	%ChargeSpinHurtBox.damage = attack * 2
	
func _on_player_leveled_up() -> void:
	effect_animation_player.play ("level_up")
	update_hp( max_hp )
	pass
	
