extends Node

static var total_award_amount : int

signal on_collectible_award_received


func give_pickup_award(collectibel_award : int):
	total_award_amount += collectibel_award
	
	on_collectible_award_received.emit(total_award_amount)
