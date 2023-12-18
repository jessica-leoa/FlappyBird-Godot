extends Node2D

# Classe Ground, que representa o comportamento do chão no jogo.
class_name Ground

# Sinal emitido quando o pássaro colide com o chão.
signal bird_crashed

# Velocidade de movimento do chão.
var speed = -150

# Referências aos sprites do chão.
@onready var sprite1 = $Ground1/Sprite1
@onready var sprite2 = $Ground2/Sprite2

# Função chamada quando o nó é inicializado.
func _ready():
	# Posiciona o segundo sprite ao lado do primeiro.
	sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()

# Função chamada a cada quadro para processamento geral.
func _process(delta):
	sprite1.global_position.x += speed * delta
	sprite2.global_position.x += speed * delta
	
	# Verifica se o primeiro sprite saiu completamente da tela e reposiciona-o.
	if sprite1.global_position.x < -sprite1.texture.get_width():
		sprite1.global_position.x = sprite2.global_position.x + sprite2.texture.get_width()
	# Verifica se o segundo sprite saiu completamente da tela e reposiciona-o.	
	if sprite2.global_position.x < -sprite2.texture.get_width():
		sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()

# Função chamada quando um corpo entra em contato com o nó.
func _body_entered(body):
	# Emite o sinal indicando que o pássaro colidiu com o chão.
	bird_crashed.emit()
	# Chama a função stop() do pássaro para interromper seu movimento.
	(body as Bird).stop()

# Função para interromper o movimento do chão.
func stop():
	speed = 0
