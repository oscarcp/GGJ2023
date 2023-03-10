extends Actor

const Bullet = preload("res://characters/Bullet.tscn")

func get_input(_delta):
    var dir = 0
    if Input.is_action_just_pressed("shoot"):
        shoot()
    if Input.is_action_pressed("move_right"):
        dir += 1
        $Sprite.set_flip_h(false)
    if Input.is_action_pressed("move_left"):
        dir -= 1
        $Sprite.set_flip_h(true)
    if dir != 0:
        velocity.x = lerp(velocity.x, dir * speed, acceleration)
    else:
        velocity.x = lerp(velocity.x, 0, friction)

func _physics_process(delta: float) -> void:
    get_input(delta)
    velocity.y += gravity * delta
    velocity = move_and_slide(velocity, Vector2.UP)
    if Input.is_action_just_pressed("jump"):
        if is_on_floor():
            velocity.y = jump_speed

func shoot():
    var b = Bullet.instance()
    owner.add_child(b)
    b.transform = $Muzzle.global_transform
