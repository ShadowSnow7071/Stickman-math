extends Sprite2D
var hide = true
func loading():
	if hide == true:
		$"../Button".hide()
		$"../Timer".start()
func _on_button_pressed():
	get_tree().change_scene_to_file("res://WORLD.tscn")


func _on_timer_timeout():
	hide = false

