extends Node2D

const PROJECTILE = preload("res://Scenes/projectile.tscn")
@onready var projectiles: Node = $Projectiles

func Fire(speed : float, at : Vector2)->void:
	var projectile: CharacterBody2D = PROJECTILE.instantiate()
	projectiles.add_child(projectile)
	#set its position on cannons position
	projectile.global_position = global_position
	projectile.speed = speed
	projectile.dir = (at - global_position).normalized()

