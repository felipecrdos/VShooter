# Classe responsável por spawnar inimigo Blankey
extends Position2D

# Variáveis
export (PackedScene) var enemy
var screen_width
var screen_height

var can_spawn	: bool
var velocity 	: Vector2
var speed 		: Vector2
var direction 	: Vector2
var offset		: Vector2

# Inicializar
func _ready():
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y
	position.x = screen_width/2
	position.y = -screen_height/2
	
	can_spawn = true
	velocity = Vector2.ZERO
	direction = Vector2.RIGHT
	speed = Vector2(50, 50)
	offset = Vector2(20, 20)

# Game Loop (movimentar)
func _physics_process(delta):
	velocity = direction * speed * delta
	position += velocity
	set_bounds()

# Definir os limites da cena spawner 
# ao se movimentar pela tela
func set_bounds():
	var on_bound = false
	if position.x <= 0:
		direction.x = 1
		on_bound = true
	elif position.x >= screen_width:
		direction.x = -1
		on_bound = true
	if can_spawn && on_bound:
		spawn_enemy()

# A Função spawn_enemy é chamada quando a scene
# spawner tocar os limites da tela
func spawn_enemy():
	offset.x = Global.choose([20, 30])
	for i in range(4):
		offset.y = Global.choose([-20, 0, 20])
		var px = position.x + (i * (direction.x * offset.x))
		var py = position.y + (i * (direction.y + offset.y * -1))
		var new = enemy.instance()
		new.set_deferred("position", Vector2(px, py))
		Global.findnode("ActorContainer").call_deferred("add_child", new)

func set_can_spawn(value:bool):
	can_spawn = value

func get_can_spawn():
	return can_spawn
