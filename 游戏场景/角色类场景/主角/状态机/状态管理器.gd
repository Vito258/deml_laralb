class_name State_Manager_Player

extends Node

# 储存所有状态的数组
var state_arr : Array = []

# 当前状态
@onready
var current = $Idle

func _ready() -> void:
	state_arr = get_children()
	current.enter() 
	
func _physics_process(delta: float) -> void:
	current.do()

# 状态转换函数
func change_state(id: int) -> void:
		current.exit()
		current = state_arr[id]
		current.enter()
		pass
