extends Node2D

@export var moveSpeed: float = 15
var snakeHand = preload("res://snake/snake_hand.tscn")
var snakeBody = preload("res://snake/snake_body.tscn")
var snake_hand
var snake_tail
var snake_tail_

var tower1_1 = preload("res://tower_1_1.tscn")

var game_start = 1

func _ready():
	create_new_snake()

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
	if Input.is_action_just_pressed("reset_test"):
		reset()
		await get_tree().create_timer(0.1).timeout
		reset()

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
		
		if Input.is_action_just_pressed("add_body_test"):
			add_body(tower1_1)

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


