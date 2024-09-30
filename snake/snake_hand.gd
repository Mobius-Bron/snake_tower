extends CharacterBody2D

var moveSpeed: float = 100 #当前部分的移动速度
var dir: Vector2 = Vector2.ZERO #移动方向

var nextBody = null #下一个身体部分
var preBody = null #上一个身体部分
var nextPoint = null
var lastPoint = Vector2.ZERO

var game_over = 0

func _physics_process(_delta):
	look_at(self.global_position+dir)
	if nextPoint:
		var d = nextPoint - self.global_position
		d.normalized()
		velocity = d * moveSpeed
	move_and_slide()

func setNextPoint(x):
	if x == null:
		return
	x.lastPoint = x.nextPoint
	x.nextPoint = x.preBody.lastPoint
	setNextPoint(x.nextBody)

func add_tower(tower):
	var new_tower = tower.instantiate()
	new_tower.position = Vector2.ZERO
	add_child(new_tower)

func _on_timer_timeout():
	if nextPoint:
		lastPoint = nextPoint
	else:
		lastPoint = self.global_position
	nextPoint = lastPoint + dir*34
	setNextPoint(nextBody)

func _on_hand_area_area_entered(area):
	game_over = 1
