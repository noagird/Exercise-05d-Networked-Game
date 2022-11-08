extends KinematicBody
		
remote func _set_position(pos):
	global_transform.origin = pos

remote func _set_rotation(rot):
	rotation.y = rot

remote func _die():
	queue_free()
