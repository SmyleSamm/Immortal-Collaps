extends Node

@onready var statistics_text: Label = %StatisticsText
var coinScore = 0
var killScore = 0

func add_point():
	coinScore += 1
	statistics_text.text = "You have collected: " +str(coinScore)+ " coins!"
	print("CoinScore: ",coinScore, "!")

func addKillPoints(points: int = 1):
	killScore += points
	print("KillScore: ",killScore,"!")
