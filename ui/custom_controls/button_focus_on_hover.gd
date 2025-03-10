extends Button


func _ready():
	mouse_entered.connect(func ():
		grab_focus()
	)


func _pressed():
	disabled = true
