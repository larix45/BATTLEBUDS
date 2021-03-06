extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal pressed()
signal released()
signal moved(direction) #Returns normalized vector with direction of movemnt
signal moved_raw(direction) # Return raw position of "stick" 

export(float) var size = 1.0
export(float) var stick_escape = 1.2
export(float) var activation_area = 5.0
export(Color) var stick_color = Color(0.0, 0.25, 0.6)
export(Color) var background_color = Color(0.2, 0.2, 0.2, 0.4)
export(Color) var stick_color_pressed = Color(0.0, 0.15, 0.4)
export(Color) var background_color_pressed = Color(0.13, 0.13, 0.13, 0.4)
var offset_pos
var pressed :bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Galka.color = stick_color
	$Tlo.color = background_color
	offset_pos = $Galka.global_position
	set_size(size)
	pass # Replace with function body.

func set_size(new_size : float):
	$Galka.size = new_size * 50
	$Tlo.size = new_size * 150
	size = new_size
	$Galka.update()
	$Tlo.update()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
func _input(event):
	if self.visible:
		if event is InputEventScreenTouch:
			if event.pressed:
				var new_pos = event.position - offset_pos
				if new_pos.x * new_pos.x + new_pos.y * new_pos.y < (100*size*activation_area)*(100*size*activation_area):
					$Tlo.color = background_color_pressed
					$Galka.color = stick_color_pressed
					emit_signal("pressed")
					pressed = true
			else:
				$Tlo.color = background_color
				$Galka.color = stick_color
				emit_signal("released")
				pressed = false
				$Galka.position = Vector2(0,0)
		if event is InputEventScreenDrag and pressed:
			emit_signal("moved", $Galka.position.normalized())
			emit_signal("moved_raw", $Galka.position)
			var new_pos = event.position - offset_pos
#			In general, x and y must satisfy (x - center_x)² + (y - center_y)² < radius².
			if not new_pos.x * new_pos.x + new_pos.y * new_pos.y < (100*size*stick_escape)*(100*size*stick_escape):
				new_pos = new_pos.normalized() * 100 * size * stick_escape
			$Galka.position = new_pos
		
	pass
