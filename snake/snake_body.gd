extends CharacterBody2D

var moveSpeed: float = 100 #当前部分的移动速度
var dir: Vector2 = Vector2.ZERO #移动方向

var nextBody = null #下一个身体部分
var preBody = null #上一个身体部分

var trace = []

func _ready():
	tracing()

func tracing():
	while true:
		add_trace(self.global_position)
		await get_tree().create_timer(0.1).timeout

func add_trace(x):
	if nextBody == null:
		return
	nextBody.trace.append(x)

func isHead():
	return preBody == null

func _physics_process(delta):
	if isHead():
		#移动当前的身体部分
		dir = dir.normalized()
		velocity = dir * moveSpeed
		move_and_slide()
	else:
		var pos = (self.global_position - preBody.global_position).length()
		#跟随前节点的路径
		if trace.is_empty() == false:
			if (trace[0] - self.global_position).length() < 200:
				global_position = global_position.move_toward(trace[0], 2)
			if (trace[0] - self.global_position).length() < 1:
				trace.pop_front()
	
