extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			# zoom in
			if event.button_index == BUTTON_LEFT:
				print("hello")
				$"../../Flutters".position = get_global_mouse_position()
			if event.button_index == BUTTON_WHEEL_UP:
				zoom =zoom * 0.9
			# zoom out
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom =zoom / 0.9
				# call the zoom function

