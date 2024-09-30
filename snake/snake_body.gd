extends CharacterBody2D

var moveSpeed: float = 100 #当前部分的移动速度
var dir: Vector2 = Vector2.ZERO #移动方向

var nextBody = null #下一个身体部分
var preBody = null #上一个身体部分
var nextPoint = null
var lastPoint = null

func _physics_process(_delta):
	if nextPoint:
		dir = nextPoint - self.global_position
		dir.normalized()
		velocity = dir * moveSpeed
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func add_tower(tower):
	var new_tower = tower.instantiate()
	new_tower.position = Vector2.ZERO
	add_child(new_tower)

