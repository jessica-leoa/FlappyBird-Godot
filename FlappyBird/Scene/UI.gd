extends CanvasLayer

# Classe UI, responsável pela interface do usuário durante o jogo.
class_name UI

# Referência ao rótulo de pontuação.
@onready var points_label = $MarginContainer/PointsLabel
# Referência à caixa de game over.
@onready var game_over_box = $MarginContainer/GameOverBox

# Função chamada quando o nó é inicializado.
func _ready():
   # Inicializa o rótulo de pontuação com o valor zero.
	points_label.text = "%d" % 0
	
# Atualiza o rótulo de pontuação com o valor fornecido.
func update_points(points: int):
		points_label.text = "%d" % points

# Exibe a caixa de game over.
func on_game_over():
	game_over_box.visible = true

# Função chamada quando o botão de reinício é pressionado (Espaco)
func _on_restart_button_pressed():
	# Recarrega a cena atual para reiniciar o jogo.
	get_tree().reload_current_scene()
