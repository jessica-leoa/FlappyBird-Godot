extends Node

# Enumeração que define os estados do jogo: IDLE (inativo), RUNNING (em execução), ENDED (encerrado)
enum GameState {IDLE, RUNNING, ENDED}

# Variável que armazena o estado atual do jogo.
var game_state

@onready var pipe_spawner = $"../PipeSpawner" as PipeSpawner
@onready var bird = get_node("../Bird") as Bird
@onready var ground = $"../Ground" as Ground
@onready var game_manager = $"."
@onready var fade = $"../Fade" as Fade
@onready var ui = $"../UI" as UI

# Variável que armazena a pontuação do jogador.
var points = 0

# Função chamada quando o nó é inicializado.
func _ready():
	game_state = GameState.IDLE	
	bird.game_started.connect(on_game_started)
	pipe_spawner.bird_crashed.connect(end_game)
	ground.bird_crashed.connect(end_game)
	pipe_spawner.point_scored.connect(point_scored)

# Função chamada quando o jogo é iniciado.
func on_game_started():
	# Define o estado do jogo como RUNNING.
	game_state = GameState.RUNNING
	 # Inicia a geração de tubos pelo PipeSpawner.
	pipe_spawner.start_spawning_pipes()

# Função chamada quando o jogo é encerrado.
func end_game():
	if fade != null: 
		fade.play()
	bird.kill()
	pipe_spawner.stop();
	ground.stop();
	ui.on_game_over()

# Função chamada quando o jogador marca um ponto.
func point_scored():
	# Incremennto dos pontos
	points += 1
	# Atualiza os pontos na interface para o jogador
	ui.update_points(points)
