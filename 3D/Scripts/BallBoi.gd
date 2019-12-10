extends KinematicBody

var velocity = Vector3(0,0,0)
const SPAWN = Vector3(0,2,0)
const SPEED = 7
const ROTSPEED = 8
const HOP = 3
const DELAY = 1.5
func _ready():
	pass
func _physics_process(delta):
	
	# jump attempt
	#if Input.is_action_just_pressed("ui_select"):
	#	velocity.y += HOP
	#	if velocity.y  == HOP:
	#		velocity.y = lerp(velocity.y,0,0.05)
	
	# If < or > is pressed (including "a" & "d" due to project settings)		
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		# stop (illusion on friction)
		velocity.x= 0
	elif Input.is_action_pressed("ui_right"):
		# apply SPEED to Ball in + x
		velocity.x = SPEED
		# rotate mesh on - Z axis simulate rolling
		$MeshInstance.rotate_z(deg2rad(-ROTSPEED))
		
	elif Input.is_action_pressed("ui_left"):
		# apply SPEED to Ball in - x
		velocity.x = -SPEED
		# rotate mesh on +Z axis simulate rolling
		$MeshInstance.rotate_z(deg2rad(ROTSPEED))
		
	else:
		# hit the brakes lerp velocity to 0 increments of 0.05
		velocity.x = lerp(velocity.x,0,0.05)
	# If ^ or v is pressed (including "w" & "s" due to project settings)	
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		velocity.z= 0
	elif Input.is_action_pressed("ui_up"):
		# apply SPEED to Ball in - z
		velocity.z= -SPEED
		# rotate mesh on -X axis simulate rolling
		$MeshInstance.rotate_x(deg2rad(-ROTSPEED))
		
	elif Input.is_action_pressed("ui_down"):
		# apply SPEED to Ball in + z
		velocity.z = SPEED
		# rotate mesh on +X axis simulate rolling
		$MeshInstance.rotate_x(deg2rad(ROTSPEED))
	else:
		velocity.z = lerp(velocity.z,0,0.05)
	move_and_slide(velocity)

# On impact with enemy
func _on_Enemy_body_entered(body):
	# Console Prinout Replace this with GUI & game Anim
	print("Hit: Health at  " + str(int(global.Health)))
	# Health -1
	global.Health -=1
	# if Health  is 0
	if global.Health == 0:
		#-1 life
		global.Lives -=1
		# Reset Level Scene
		get_tree().change_scene("res://Level.tscn")
		# Reset Health as Scene Resets
		global.Health = 3
		print("Lives:  " + str(int (global.Lives)))
		# When Lives == 0 present Game Over Screen
	elif global.Lives == 0:
		move_and_slide(SPAWN)
		get_tree().change_scene("res://Assets/Scenes/GameOver.tscn")

