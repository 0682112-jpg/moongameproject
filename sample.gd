extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.samples_collected += 1
		print(Global.samples_collected)
		
		self.queue_free() # delete object
