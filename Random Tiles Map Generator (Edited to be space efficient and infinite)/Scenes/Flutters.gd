extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var MoveX = Input.get_action_strength("Right")-Input.get_action_strength("Left")
	var MoveY = Input.get_action_strength("Down")-Input.get_action_strength("Up")
	move_and_slide(Vector2(MoveX,MoveY)*(2-Input.get_action_strength("Shift")*(1.5)+Input.get_action_strength("Ctrl")*10)*100)
	#position+=Vector2(MoveX,MoveY)*(2-Input.get_action_strength("Shift")*(1.5)+Input.get_action_strength("Ctrl")*10)*100*delta
	
