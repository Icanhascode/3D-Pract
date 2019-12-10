extends Label

var stars = 0

func _ready():
	text = str(stars)


func _on_Star_coinCollected():
	stars = stars+1
	_ready()
