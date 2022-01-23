extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move_vector = Vector2(0, 0)
	if Input.is_action_pressed("ui_down"):
		move_vector.y += 10
	if Input.is_action_pressed("ui_up"):
		move_vector.y -= 10
	if Input.is_action_pressed("ui_left"):
		move_vector.x -= 10
	if Input.is_action_pressed("ui_right"):
		move_vector.x += 10
	self.move_and_collide(move_vector)
	pass


func _on_Joystick_moved(direction):
	self.move_and_collide(direction*10)
	pass # Replace with function body.
