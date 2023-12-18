extends CharacterBody2D

# Classe Bird, que representa o comportamento de um pássaro no jogo.
class_name Bird
# Sinal emitido quando o jogo é iniciado.
signal game_started

# Variável exportada para ajustar a gravidade do pássaro.
@export var gravity = 900.0
# Variável exportada para definir a força do salto do pássaro.
@export var jump_force: int = -300
# Referência ao AnimationPlayer para controlar as animações.
@onready var animation_player = $AnimationPlayer

# Velocidade máxima do pássaro.
var max_speed = 400
# Velocidade de rotação do pássaro.
var rotation_speed = 2

# Flag que indica se o jogo foi iniciado.
var is_started = false
# Flag que controla se o processamento de entrada deve ocorrer.
var should_process_input = true

# Função chamada quando o nó é inicializado.
func _ready():
	velocity = Vector2.ZERO
	animation_player.play("idle")

# Função chamada a cada quadro para processamento de física.
func _physics_process(delta):
	if Input.is_action_just_pressed("jump") && should_process_input:
		if !is_started: 
			animation_player.play("flap_wings")
			game_started.emit()
			is_started = true
		jump()
		
	if !is_started:
		return
		
	# Aplica a gravidade ao pássaro.
	velocity.y += gravity * delta
	# Limita a velocidade vertical máxima do pássaro.
	if velocity.y > max_speed:
		velocity.y = max_speed
	
	# Move o pássaro e lida com colisões.
	move_and_collide(velocity * delta)
	 # Rotaciona o pássaro com base na velocidade.
	rotate_bird()
	
# Função para realizar o salto do pássaro.
func jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-30)
			
# Função para ajustar a rotação do pássaro com base na velocidade.
func rotate_bird():
	if velocity.y > 0 and rad_to_deg(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1)
	elif velocity.y < 0 and rad_to_deg(rotation) > -30:
		rotation -= rotation_speed * deg_to_rad(1)

# Função para desativar o processamento de entrada.
func kill():
	should_process_input = false
# Função para interromper as animações e a gravidade do pássaro.
func stop():
	animation_player.stop()
	gravity = 0
	velocity = Vector2.ZERO
