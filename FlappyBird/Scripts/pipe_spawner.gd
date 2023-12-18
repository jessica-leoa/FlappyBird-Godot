extends Node

# Classe PipeSpawner, responsável por gerar e controlar a movimentação dos tubos no jogo.
class_name PipeSpawner

# Sinal emitido quando o pássaro colide com um tubo.
signal bird_crashed
# Sinal emitido quando o jogador marca um ponto ao passar por um tubo.
signal point_scored

# Cena do par de tubos a ser instanciada.
var pipe_pair_scene = preload("res://Scene/pipe_pair.tscn")

# Variável exportada que define a velocidade dos tubos.
@export var pipe_speed = -150
# Referência ao temporizador responsável pela geração contínua de tubos.
@onready var spawn_timer = $SpawnTimer


# Função chamada quando o nó é inicializado.
func _ready():
	spawn_timer.timeout.connect(spawn_pipe)
	
# Inicia a geração contínua de tubos.
func start_spawning_pipes():
	spawn_timer.start()

# Função responsável por instanciar e posicionar um novo par de tubos.
func spawn_pipe():
	var pipe = pipe_pair_scene.instantiate() as PipePair
	add_child(pipe)
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	var half_height = viewport_rect.size.y / 2
	pipe.position.x = viewport_rect.end.x
	pipe.position.y = randf_range(viewport_rect.size.y * 0.15 - half_height, viewport_rect.size.y * 0.65 - half_height)
	
	pipe.bird_entered.connect(on_bird_entered)
	pipe.point_scored.connect(on_point_scored)
	pipe.set_speed(pipe_speed)

# Função chamada quando o pássaro colide com um tubo.
func on_bird_entered():
	bird_crashed.emit()
	stop()

# Função para interromper a geração de tubos.
func stop():
	spawn_timer.stop()
	for pipe in get_children().filter(func (child): return child is PipePair):
		(pipe as PipePair).speed = 0

# Função chamada quando o jogador marca um ponto.
func on_point_scored():
	point_scored.emit()


	
