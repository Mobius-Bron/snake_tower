extends StaticBody2D

var enemyList = []

@onready var tower = $tower
var bullet = preload("res://towers/bullet.tscn")

var target_enemy = null

func _on_tower_area_area_entered(area):
	if area.name == "enemy_area":
		var node = area.get_parent()
		if node not in enemyList:
			enemyList.append(node)

func _on_tower_area_area_exited(area):
	if area.name == "enemy_area":
		var node = area.get_parent()
		if node in enemyList:
			enemyList.erase(node)

func _on_timer_timeout():
	target_enemy = null
	var enemy_S = 1000
	for enemy in enemyList:
		if enemy == null:
			enemyList.erase(enemy)
			continue
		if (self.global_position - enemy.global_position).length() < enemy_S:
			target_enemy = enemy
			enemy_S = (self.global_position - enemy.global_position).length()
	
	if target_enemy:
		tower.look_at(target_enemy.global_position)
		var new_bullet1 = bullet.instantiate()
		new_bullet1.global_position = $tower/tower/aim1.global_position
		new_bullet1.target = target_enemy
		var new_bullet2 = bullet.instantiate()
		new_bullet2.global_position = $tower/tower/aim2.global_position
		new_bullet2.target = target_enemy
		var new_bullet3 = bullet.instantiate()
		new_bullet3.global_position = $tower/tower/aim3.global_position
		new_bullet3.target = target_enemy
		get_tree().get_root().add_child(new_bullet1)
		get_tree().get_root().add_child(new_bullet2)
		get_tree().get_root().add_child(new_bullet3)
