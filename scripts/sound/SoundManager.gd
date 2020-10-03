extends Node2D

onready var bus_layout = preload("res://resources/bus.tres")
var tween_music

func _ready():
	AudioServer.set_bus_layout(bus_layout)
	#set_bus_volume("SfxBus", -20)
	tween_music = $Music.get_node("Tween")
	
func set_bus_volume(bus_name:String, volume:float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), volume)

func fade_out_music(audio:String, volume:float = -80, duration:float = 2):
	stop_all_music(audio)
	var stream = $Music.get_node(audio)
	tween_music.stop(stream)
	tween_music.interpolate_property(stream, ":volume_db", stream.get_volume_db(), volume, duration, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	tween_music.start()

func fade_in_music(audio:String, volume:float = 0, duration:float = 2):
	stop_all_music(audio)
	var stream = $Music.get_node(audio)
	stream.play()
	tween_music.stop(stream)
	tween_music.interpolate_property(stream, ":volume_db", stream.get_volume_db(), volume, duration, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	tween_music.start()
	
func play_sfx(audio:String):
	$Sfx.get_node(audio).play()

func play_music(audio:String):
	$Music.get_node(audio).play()

func pause_music(audio:String):
	var stream = $Music.get_node(audio)
	if(!stream.stream_paused):
		stream.stream_paused = true
func pause_all_music():
	for child in $Music.get_children():
		if child is AudioStreamPlayer && !child.stream_paused:
			child.stream_paused = true
			
func resume_all_music():
	for child in $Music.get_children():
		if child is AudioStreamPlayer && child.stream_paused:
			child.stream_paused = false
			
func resume_music(audio:String):
	var stream = $Music.get_node(audio)
	if(stream.stream_paused):
		stream.stream_paused = false
		
func stop_music(audio:String):
	$Music.get_node(audio).stop()

func stop_all_music(except:String):
	var stream = $Music.get_node(except)
	for child in $Music.get_children():
		if child is AudioStreamPlayer && child != stream:
			child.stop()
			child.set_volume_db(-80)
