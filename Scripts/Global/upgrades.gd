extends Node

#list for simple use
enum Names{
	SIZEUP = 1,
	SPEEDUP = 2,
	LIFEUP = 3,
	METERMAXUP = 4,
	METERSPEEDUP = 5,
	METERPOWERUP = 6
}

#single upgrade can have multiple effects within them
#effects have single consequence
func Upgrade(upgrade : int)-> void:
	match upgrade:
		Names.SIZEUP:
			Effects.AddSize(1)
			Effects.AddSpeed(0)
		Names.SPEEDUP:
			Effects.AddSpeed(1)
		Names.LIFEUP:
			Effects.AddMaxLife(1)
		Names.METERMAXUP:
			Effects.MeterAddMax(1)
		Names.METERSPEEDUP:
			Effects.MeterAddSpeed(1)
		Names.METERPOWERUP:
			Effects.MeterAddPower(1)
		
