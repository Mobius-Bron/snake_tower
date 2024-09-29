extends CharacterBody2D

var moveSpeed: float = 100 #当前部分的移动速度
var dir: Vector2 = Vector2.ZERO #移动方向

var nextBody = null #下一个身体部分
var preBody = null #上一个身体部分
var nextPoint = null
var lastPoint = null

func _ready():
	if isHead():
		while 1:
			if nextPoint:
				lastPoint = nextPoint
			else:
				lastPoint = self.global_position
			nextPoint = self.global_position + dir*17
			setNextPoint(nextBody)
			await get_tree().create_timer(0.1).timeout

func isHead():
	return preBody == null

func _physics_process(delta):
	if nextPoint:
		if isHead():
			var d = nextPoint - self.global_position
			d.normalized()
			velocity = d * moveSpeed / 5
		else:
			dir = nextPoint - self.global_position
			dir.normalized()
			velocity = dir * moveSpeed / 5
	move_and_slide()

func setNextPoint(x):
	if x == null:
		return
	x.lastPoint = x.nextPoint
	x.nextPoint = x.preBody.lastPoint
	setNextPoint(x.nextBody)
