extends CharacterBody2D

var hp: = 30
var speed = 80
var target_position: Vector2

func get_v():
	var dir = target_position - self.global_position
	dir = dir.normalized()
	return dir * speed

func _physics_process(_delta):
	look_at(target_position)
	velocity = get_v()
	move_and_slide()
	if (self.global_position - target_position).length() <= 10:
		queue_free()

func hurt(_atk):
	hp -= _atk
	if hp <= 0:
		get_parent().enemy_dead()
		queue_free()

func set_rand_color():
	$png.modulate = Color8(randi_range(1,255),randi_range(1,255),randi_range(1,255))
