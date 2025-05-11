extends StaticBody2D

class_name BreakoutBlock

@onready var color: ColorRect = $ColorRect

#Black = Color (0, 0, 0, 1)
#White = Color (255,255,255,1)

##change color with respect to remaining health
@export var health = 3
@export var score = 100


#changes color based on remaining health
func ColorReset() ->void:
	var newC = (127. + 64. *(health-1))/255.
	color.color = Color(newC,newC,newC,255)

func _ready() -> void:
	ColorReset()

#takes damage and maybe dies
func BallCollision()->void:
	health -= 1
	if health <= 0:
		##add effects here
		queue_free()
	ColorReset()
