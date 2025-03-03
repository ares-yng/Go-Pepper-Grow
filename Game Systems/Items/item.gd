extends Area2D

var itemData

@onready var sparkleParticles = $Sprite2D/GPUParticles2D

func pickup():
	return getData()
func useItem(quantity):
	setQuantity(getQuantity()-quantity)
	if getQuantity() < 1:
		return true

func stopDroppedAnimation():
	unsparkle()
func playDroppedAnimation():
	sparkle()
func sparkle():
	sparkleParticles.emitting = true
func unsparkle():
	sparkleParticles.emitting = false
func flash():
	$Sprite2D.material.set("shader_parameter/flashModifier", 1)
	$Sprite2D/FlashTimer.start()
func _on_flash_timer_timeout():
	$Sprite2D.material.set("shader_parameter/flashModifier", 0)

func setQuantity(quantity):
	var quantityNode = $Quantity
	itemData["quantity"] = quantity
	quantityNode.text = str(quantity)
	if quantity == 1:
		quantityNode.visible = false
	else:
		quantityNode.visible = true
func addQuantity(quantity): #returns the number of items not added
	var total = getQuantity() + quantity
	if total > getStackMax():
		setQuantity(getStackMax())
		return total - getStackMax()
	else:
		setQuantity(total)
		return 0
func getTexture():
	return $Sprite2D.get_texture()

func getData():
	var data = {"item_id": getItemID(), "quantity": getQuantity()}
	return data
func setVariables(itemID, quantity = 1):
	var db = load("res://Game Systems/Resources/database_resource.gd").new()
	itemData = db.getDictionary("parameters", "item_data", "*", "item_id", itemID)
	setQuantity(quantity)
	var spriteNode = $Sprite2D
	var texture = load(str("res://Game Systems/Items/Item Assets/", getItemFilename(), ".png"))
	spriteNode.set_texture(texture)

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
