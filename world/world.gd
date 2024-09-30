extends Node2D

@export var moveSpeed: float = 15
var snakeHand = preload("res://snake/snake_hand.tscn")
var snakeBody = preload("res://snake/snake_body.tscn")
var snake_hand
var snake_tail
var snake_tail_

var tower1_1 = preload("res://towers/tower_1_1.tscn")
var tower1_2 = preload("res://towers/tower_1_2.tscn")
var tower1_3 = preload("res://towers/tower_1_3.tscn")

var enemy = preload("res://enemy/enemy.tscn")

var game_start = 1
var coin:int = 0

func add_new_enemy():
	var new_enemy = enemy.instantiate()
	var pos_kind = randi_range(1,4)
	var x1
	var x2
	var y1
	var y2
	if pos_kind == 1:
		x1 = randf_range(-600, 600)
		x2 = randf_range(-600, 600)
		y1 = -400
		y2 = 400
	elif pos_kind == 2:
		x1 = randf_range(-600, 600)
		x2 = randf_range(-600, 600)
		y1 = 400
		y2 = -400
	elif pos_kind == 3:
		x1 = -800
		x2 = 800
		y1 = randf_range(-300, 300)
		y2 = randf_range(-300, 300)
	elif pos_kind == 4:
		x1 = 800
		x2 = -800
		y1 = randf_range(-300, 300)
		y2 = randf_range(-300, 300)
	new_enemy.global_position = Vector2(x1,y1)
	new_enemy.target_position = Vector2(x2,y2)
	add_child(new_enemy)

func _ready():
	create_new_snake()
	add_new_enemy()

func create_new_snake():
	snake_hand = snakeHand.instantiate()
	snake_tail = snakeBody.instantiate()
	
	snake_hand.global_position = Vector2(0,0)
	snake_tail.global_position = Vector2(-34,0)
	
	snake_hand.moveSpeed = moveSpeed
	snake_tail.moveSpeed = moveSpeed
	
	snake_hand.nextBody = snake_tail
	snake_tail.preBody = snake_hand
	
	snake_tail_ = snake_tail
	
	add_child(snake_hand)
	add_child(snake_tail)

func _process(_delta):
	$snake_body_shop/coin_num.text = "金币数量："+str(coin)
	if snakeHand != null:
		if snake_hand.game_over:
			reset()
		
		if Input.is_action_pressed("ui_up") and snake_hand.dir != Vector2.DOWN:
			snake_hand.dir = Vector2.UP
		if Input.is_action_pressed("ui_down") and snake_hand.dir != Vector2.UP:
			snake_hand.dir = Vector2.DOWN
		if Input.is_action_pressed("ui_right") and snake_hand.dir != Vector2.LEFT:
			snake_hand.dir = Vector2.RIGHT
		if Input.is_action_pressed("ui_left") and snake_hand.dir != Vector2.RIGHT:
			snake_hand.dir = Vector2.LEFT

func add_body(tower = null):
	var new_body = snakeBody.instantiate()
	new_body.preBody = snake_tail_
	snake_tail_.nextBody = new_body
	new_body.global_position = snake_tail_.global_position
	new_body.moveSpeed = moveSpeed
	snake_tail_ = new_body
	
	if tower != null: #为蛇身体节点添加指定防御塔
		new_body.add_tower(tower)
	
	add_child(new_body)

func reset():
	coin = 0
	clear_snake(snake_hand)
	snake_hand = null
	create_new_snake()

func clear_snake(x):
	var node = x
	var node_
	while node != null:
		node_ = node.nextBody
		node.queue_free()
		node = node_

func _on_enemy_timer_timeout():
	add_new_enemy()
	$enemy_timer.wait_time = randf_range(0.5, 3)

func _on_add_null_button_down():
	coin += 25
	add_body()

func _on_add_tower_1_button_down():
	if coin >= 30:
		add_body(tower1_1)
		coin -= 30

func _on_add_tower_2_button_down():
	if coin >= 60:
		add_body(tower1_2)
		coin -= 60

func _on_add_tower_3_button_down():
	if coin >= 80:
		add_body(tower1_3)
		coin -= 80
