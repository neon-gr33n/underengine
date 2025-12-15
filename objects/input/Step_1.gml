up_pressed = input_check_pressed("up")
up = input_check("up") || input_is_analogue("up")
up_released = input_check_released("up")

down_pressed = input_check_pressed("down")
down = input_check("down") || input_is_analogue("down")
down_released = input_check_released("down")

left_pressed = input_check_pressed("left")
left = input_check("left") || input_is_analogue("left")
left_released = input_check_released("left")

right_pressed = input_check_pressed("right")
right = input_check("right") || input_is_analogue("right")
right_released = input_check_released("right")

action_pressed = input_check_pressed("action")
action = input_check("action")
action_released = input_check_released("action")

menu_pressed = input_check_pressed("menu")
menu = input_check("menu")
menu_released = input_check_released("menu")

cancel_pressed = input_check_pressed("cancel")
cancel = input_check("cancel")
cancel_released = input_check_released("cancel")

pause_pressed = input_check_pressed("pause")
pause = input_check("pause")
pause_released = input_check_released("pause")