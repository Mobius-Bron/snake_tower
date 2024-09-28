extends Node2D

@export var moveSpeed: float = 100
var snakeBody = preload("res://snake/snake_body.tscn")
var snakeHand
var snakeTail

# Called when the node enters the scene tree for the first time.
func _ready():
	snakeHand = snakeBody.instantiate()
	snakeTail = snakeHand
	snakeHand.global_position = Vector2.ZERO
	snakeHand.moveSpeed = moveSpeed
	add_child(snakeHand)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		snakeHand.dir = Vector2.UP
	if Input.is_action_pressed("ui_down"):
		snakeHand.dir = Vector2.DOWN
	if Input.is_action_pressed("ui_right"):
		snakeHand.dir = Vector2.RIGHT
	if Input.is_action_pressed("ui_left"):
		snakeHand.dir = Vector2.LEFT
		
	if Input.is_action_just_pressed("ui_accept"):
		add_body()
		
func add_body():
	var new_body = snakeBody.instantiate()
	new_body.preBody = snakeTail
	snakeTail.nextBody = new_body
	new_body.global_position = snakeTail.global_position
	new_body.moveSpeed = moveSpeed
	snakeTail = new_body
	add_child(new_body)
