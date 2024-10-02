extends CharacterBody2D

var atk = 3
var speed = 200
var dir = Vector2.RIGHT
var target
var is_through = 0
var kind = 0

func _ready():
	look_at(target.global_position)

func _physics_process(_delta):
	if target != null and is_through == 0:
		dir = target.global_position - self.global_position
		dir = dir.normalized()
	velocity = dir * speed
	move_and_slide()

func _on_area_2d_area_entered(area):
	if area.name == "enemy_area":
		var node = area.get_parent()
		node.hurt(atk)
		if kind == 0:
			queue_free()
		elif kind == 1:
			target = area.get_parent()
		elif kind == 2:
			is_through = 1
	elif area.name == "world_area":
		queue_free()
