# Cena para efeitos de explosão
# As animações são definidas no nó
# AnimatedSprite.
extends Node2D

# Função que recebe o nome da animação 
# a ser iniciada ao instanciada esta cena.
func play(value : String, speed : float):
	$ASprite.frames.set_animation_speed(value, speed)
	$ASprite.play(value)
	yield($ASprite, "animation_finished")
	queue_free()
	
