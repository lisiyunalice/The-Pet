extends Node

var remaining_time: float = 100.0
var last_timestamp = Time.get_unix_time_from_system()

signal stats_changed

# 这里存储主游戏的全局状态
var player_stats = {
	"happy": 50,
	"energy": 50,
	"food": 50
}
var max_happy: int = 100
var max_energy: int = 100
var max_food: int = 100

# 比如迷你游戏可以调用这个函数增加奖励
func add_reward(happy: int = 0, energy: int = 0, food: int = 0):
	player_stats["happy"] += happy
	player_stats["energy"] += energy
	player_stats["food"] += food
	#emit_signal("stats_changed")
	print("Rewarded! Current Pet Status: ", player_stats)
