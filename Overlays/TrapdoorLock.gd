extends TextureRect

#var digits = ['0','1','2','3','4','5','6','7','8','9']

var digit1 = 0
var digit2 = 0
var digit3 = 0

func _ready():
	# cursors for buttons
	MouseHelper.set_cursor('up', Input.CURSOR_CROSS)
	MouseHelper.set_cursor('down', Input.CURSOR_HSIZE)

func check_code():
	if digit1 == 7 and digit2 == 2 and digit3 == 4:
		unlock()

func unlock():
	# remove overlay
	WorldData.is_trapdoor_locked = false
	$"..".queue_free()

func _on_D1up_pressed():
	digit1 = (digit1 + 1) % 10
	$Digit1.text = str(digit1)
	check_code()
func _on_D1down_pressed():
	digit1 = digit1 - 1
	if digit1 < 0: digit1 = 9
	$Digit1.text = str(digit1)
	check_code()

func _on_D2up_pressed():
	digit2 = (digit2 + 1) % 10
	$Digit2.text = str(digit2)
	check_code()
func _on_D2down_pressed():
	digit2 = digit2 - 1
	if digit2 < 0: digit2 = 9
	$Digit2.text = str(digit2)
	check_code()

func _on_D3up_pressed():
	digit3 = (digit3 + 1) % 10
	$Digit3.text = str(digit3)
	check_code()
func _on_D3down_pressed():
	digit3 = digit3 - 1
	if digit3 < 0: digit3 = 9
	$Digit3.text = str(digit3)
	check_code()
