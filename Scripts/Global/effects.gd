extends Node

var player : Player

#heal/damage added amount
func AddLife(added:int)->void:
	Globals.ChangeLife(added)


#bool = 1 == increase, 0 == reduce
func AddSpeed(increase: bool)->void:
	if increase:
		Globals.ChangeSpeed(1)
	else:
		Globals.ChangeSpeed(-1)

#bool = 1 == increase, 0 == reduce
func AddSize(increase: bool)->void:
	if increase:
		Globals.ChangeSize(1)
	else:
		Globals.ChangeSize(-1)

#bool = 1 == increase, 0 == reduce
func AddMaxLife(increase : bool)->void:
	if increase:
		Globals.ChangeMaxLife(1)
	else:
		Globals.ChangeMaxLife(-1)

func MeterAddMax(increase : bool)->void:
	if increase:
		Globals.ChangeMeterMax(1)
	else:
		Globals.ChangeMeterMax(-1)

func MeterAddSpeed(increase : bool)->void:
	if increase:
		Globals.ChangeMeterSpeed(1)
	else:
		Globals.ChangeMeterSpeed(-1)

func MeterAddPower(increase : bool)->void:
	if increase:
		Globals.ChangeMeterPower(1)
	else:
		Globals.ChangeMeterPower(-1)
