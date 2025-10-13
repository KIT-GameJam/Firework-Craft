extends Resource
class_name FireworkResource

@export var size_modifier: int
@export var color_modifier: int # 0-11 (12 Verschiedene Farben)
@export var corner_modifier: int

const colors = {
	1: Color('f4e601'), # yellow
	2: Color('f9c30b'), # yellow_orange
	3: Color('f28e1e'), # orange
	4: Color('eb6120'), # orange_red
	5: Color('e12323'), # red
	6: Color('c1027b'), # purple_red
	7: Color('6d398b'), # purple
	8: Color('444d98'), # purple_blue
	9: Color('2b70b1'), # blue
	10: Color('0797bc'), # light_blue
	11: Color('018e5a'), # green
	12: Color('8dbb27') # olive
}
