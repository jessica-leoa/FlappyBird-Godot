extends Node

# Classe Fade, responsável por realizar efeitos de fade na cena.
class_name Fade

# Referência ao AnimationPlayer para controlar as animações.
@onready var animation_player = $AnimationPlayer

# Inicia a animação de fade.
func play():
	animation_player.play("fade")

# Função chamada quando a animação no AnimationPlayer é concluída.
func _on_animation_player_animation_finished(anim_name):
	queue_free()
