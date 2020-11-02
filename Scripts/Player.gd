extends KinematicBody2D

#Constants
const nGrav = 40
const nSpeed = 450
const nJumpPower = -1000
const vUp = Vector2(0, -1)

#Variables
var vMotion = Vector2()

#Begin Phys Proc
func _physics_process(delta):
	
	#Keep player grounded 
	vMotion.y += nGrav
	
	#Horizontal Movement
	if Input.is_action_pressed("ui_left"): #Go left
		vMotion.x = -nSpeed #Set motion to vector
		
		#Play run animation
		if is_on_floor(): 
			$Animation.play("Run")
			
		$Animation.flip_h = true #Flip
	elif Input.is_action_pressed("ui_right"): #Go right
		vMotion.x = nSpeed #Set motion to vector
		
		#Play run animation
		if is_on_floor(): 
			$Animation.play("Run")
		
		$Animation.flip_h = false #No flip
	else: #Don't move
		vMotion.x = 0
		$Animation.play("Idle")
	
	#Jump
	if is_on_floor(): #Jump only when on floor
		if Input.is_action_just_pressed("ui_up"): #and when the up key is pressed
			vMotion.y = nJumpPower #Set jump power to vector
			$Animation.play("Jump") #Play jump animation
			
	#Land
	if !is_on_floor(): #Land only when in air
		if vMotion.y > 0: #and going down
			$Animation.play("Land") #Play landing animation
	
	#Apply all motion
	vMotion = move_and_slide(vMotion, vUp)
	pass
