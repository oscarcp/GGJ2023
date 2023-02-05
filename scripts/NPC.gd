extends Area2D

var active = false
var already_shown = false
var resource = preload("res://characters/dialogue.tres")

#func _ready():
#    connect("body_entered", self, "_on_NPC_body_entered")
#    connect("body_exited", self, "_on_NPC_body_exited")

func _process(_delta):
    $QuestionMark.visible = active


func _input(event):
        if event.is_action_pressed("interact") and active:
            get_tree().paused = true
            var dialog = Dialogic.start('timeline-1')
            dialog.pause_mode = Node.PAUSE_MODE_PROCESS
            dialog.connect('timeline_end', self, 'unpause')
            add_child(dialog)

func unpause(timeline_name):
    get_tree().paused = false


func _on_NPC_body_entered(body):
    if body.name == 'Player':
        active = true
    
func _on_NPC_body_exited(body):
    if body.name == 'Player':
        active = false
