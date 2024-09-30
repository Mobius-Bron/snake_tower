extends CharacterBody2D

var atk = 3
var speed = 200
var dir = Vector2.RIGHT
var target
var through_able = 0

func _ready():
	look_at(target.global_position)

func _physics_process(_delta):
	if target != null:
		dir = target.global_position - self.global_position
		dir = dir.normalized()
	velocity = dir * speed
	move_and_slide()

func _on_area_2d_area_entered(area):
	if area.name == "enemy_area":
		var node = area.get_parent()
		node.hurt(atk)
		if through_able == 0:
			queue_free()
	elif area.name == "world_area":
		queue_free()
