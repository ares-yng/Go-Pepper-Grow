extends Area2D

var itemData

@onready var sparkleParticles = $Sprite2D/GPUParticles2D
@onready var animationPlayer = $Sprite2D/AnimationPlayer
@onready var itemSprite = $Sprite2D
@onready var flashTimer = $Sprite2D/FlashTimer
@onready var quantityLabel = $Quantity


func pickup():
	return getData()
func useItem(quantity):
	setQuantity(getQuantity()-quantity)
	if getQuantity() < 1:
		return true

func stopDroppedAnimation():
	unsparkle()
func playDroppedAnimation():
	animationPlayer.play("dropped")
	sparkle()
func sparkle():
	sparkleParticles.restart()
	sparkleParticles.emitting = true
func unsparkle():
	sparkleParticles.emitting = false
func flash():
	itemSprite.material.set("shader_parameter/flashModifier", 1)
	flashTimer.start()
func _on_flash_timer_timeout():
	itemSprite.material.set("shader_parameter/flashModifier", 0)

func setQuantity(quantity):
	quantityLabel = $Quantity
	
	itemData["quantity"] = quantity
	quantityLabel.text = str(quantity)
	if quantity == 1:
		quantityLabel.visible = false
	else:
		quantityLabel.visible = true
func addQuantity(quantity): #returns the number of items not added
	var total = getQuantity() + quantity
	if total > getStackMax():
		setQuantity(getStackMax())
		return total - getStackMax()
	else:
		setQuantity(total)
		return 0
func getTexture():
	return itemSprite.get_texture()

func getData():
	var data = {"item_id": getItemID(), "quantity": getQuantity()}
	return data
func setVariables(itemID, quantity = 1):
	itemSprite = $Sprite2D
	
	var db = load("res://Game Systems/Resources/database_resource.gd").new()
	itemData = db.getDictionary("parameters", "item_data", "*", "item_id", itemID)
	setQuantity(quantity)
	var texture = load(str("res://Game Systems/Items/Item Assets/", getItemFilename(), ".png"))
	itemSprite.set_texture(texture)

func getItemID():
	return itemData["item_id"]
func getName():
	return itemData["name"]
func getItemFilename():
	return itemData["item_filename"]
func getEquipmentFilename():
	return itemData["equipment_filename"]
func getAction():
	return itemData["action"]
func getUseDetailsID():
	return itemData["use_details_id"]
func getChargeLeftActionID():
	return itemData["charge_left_action_id"]
func getChargeRightActionID():
	return itemData["charge_right_action_id"]
func getStackMax():
	return itemData["stack_max"]
func getQuantity():
	return itemData["quantity"]
