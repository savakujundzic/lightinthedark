extends Node2D
@onready var light = $Light
@onready var dark = $dark

signal coll_changed

func _physics_process(delta):
	if Input.is_action_just_pressed("switch"):
		if light.visible == true:
				light.hide()
				dark.show()
				coll_changed.emit()
		else:
			light.show()
			dark.hide()
			coll_changed.emit()
