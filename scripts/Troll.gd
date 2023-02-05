extends Actor

var flipped_left = false
var player_in_view = false
var target = null
var is_attacking = false


func _ready():
    $AnimatedSprite.animation = 'idle'
    $AnimatedSprite.playing = true


func _physics_process(delta: float) -> void:
    var motion = Vector2.ZERO
    if target:
        #print("TARGET: %s" % target.position.x)
        #print("ENEMY: %s" % $".".position.x)
        if target.position.x < $".".position.x:
            print("POR TU IZQUIERDA!")
            $AnimatedSprite.flip_h = true
            $AttackArea/AttackCollision.position = Vector2(-22.5, 11)
        if target.position.x > $".".position.x:
            $AnimatedSprite.flip_h = false
            $AttackArea/AttackCollision.position = Vector2(22.5, -11)
        #$AnimatedSprite.animation = 'run'
        motion = global_position.direction_to(target.global_position) * (speed / 10)
        motion.y = (2*gravity) * delta
    motion = move_and_slide(motion, Vector2.UP)


func _on_PlayerDetection_body_entered(body: Node) -> void:
    if body.name == 'Player':
        target = body
        player_in_view = true
        $AnimatedSprite.animation = 'run'

func _on_PlayerDetection_body_exited(body: Node) -> void:
    if body.name == 'Player':
        target = null
        $AnimatedSprite.animation = 'idle'


func _on_AttackArea_body_entered(body: Node) -> void:
    if body.name == 'Player':
        $AnimatedSprite.animation = 'attack'
        is_attacking = true


func _on_AttackArea_body_exited(body: Node) -> void:
    if body.name == 'Player':
        $AnimatedSprite.animation = 'run'


func _on_AnimatedSprite_animation_finished() -> void:
    if $AnimatedSprite.animation == 'attack':
        is_attacking = false
