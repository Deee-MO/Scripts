extends Node
##All Music stuff
#streams
@onready var main: AudioStreamPlayer2D = $Music/Main
@onready var boss: AudioStreamPlayer2D = $Music/Boss
@onready var shop: AudioStreamPlayer2D = $Music/Shop
#enum for using dictionary
enum MUSIC{
	MAIN = 1,
	BOSS = 2,
	SHOP = 3
}
#dictionary for calling streams
var Music = {
	MUSIC.MAIN : null,
	MUSIC.BOSS : null,
	MUSIC.SHOP : null,
}
#keep track of current music track, set to play shop on launch
var curTrack : int = 1

#switch music track
func SwitchMusic(track: int)->void:
	#dont do anything if the right track is playing
	if track == curTrack:
		return
	#positiion from which to start next track
	var curPosition = 0
	#if a track is already playing get its position
	if Music[curTrack].has_stream_playback():
		curPosition = Music[curTrack].get_playback_position()
	#start next track from current tracks position
	Music[track].play(curPosition)
	#stop previous track
	Music[curTrack].stop()
	#update current track tracker
	curTrack = track
	
## ALL Sound stuff
#streams
@onready var ball_lost: AudioStreamPlayer2D = $Sound/BallLost
@onready var block_hit: AudioStreamPlayer2D = $Sound/BlockHit
@onready var game_over: AudioStreamPlayer2D = $Sound/GameOver
@onready var level_clear: AudioStreamPlayer2D = $Sound/LevelClear
@onready var overtime: AudioStreamPlayer2D = $Sound/Overtime
@onready var wall_hit: AudioStreamPlayer2D = $Sound/WallHit
#enum for using dictionary
enum SOUND{
	BALLLOST = 1,
	HITBLOCK = 2,
	GAMEOVER = 3,
	LEVELCLEAR = 4,
	OVERTIME = 5,
	HITWALL = 6
}
#dictionary for calling streams
var Sound = {
	SOUND.BALLLOST : null,
	SOUND.HITBLOCK : null,
	SOUND.GAMEOVER : null,
	SOUND.LEVELCLEAR : null,
	SOUND.OVERTIME : null,
	SOUND.HITWALL : null,
}

func PlaySound(sound:int) ->void:
	Sound[sound].play()

func _ready() -> void:
	#transfer stream addresses from variables to lists and free the variables
	Music[MUSIC.MAIN] = main
	main = null
	Music[MUSIC.BOSS] = boss
	boss = null
	Music[MUSIC.SHOP] = shop
	shop = null

	Sound[SOUND.BALLLOST] = ball_lost
	ball_lost = null
	Sound[SOUND.HITBLOCK] = block_hit
	block_hit = null
	Sound[SOUND.GAMEOVER] = game_over
	game_over = null
	Sound[SOUND.LEVELCLEAR] = level_clear
	level_clear = null
	Sound[SOUND.OVERTIME] = overtime
	overtime = null
	Sound[SOUND.HITWALL] = wall_hit
	wall_hit = null
