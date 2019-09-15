------- MAIN STYLES ----------

defineTile{
	name = "fire_cave_floor",
	editorIcon = 192,
	color = {142,105,105,255},
	builder = "dungeon",
	randomFloorFacing = true,
	floor = {
		"fire_cave_floor1", 1,
	},
	ceiling = {
		"mine_moss_ceiling_01", 1,
		"mine_moss_ceiling_02", 1,
		"mine_moss_ceiling_03", 1,
	},
	wall = {
		"rc_elevation_edge_01", 1,
		"rc_elevation_edge_02", 1,
	},
}

defineTile{
	name = "fire_cave_wall",
	editorIcon = 196,
	color = {70,100,70,255},
	solid = true,
	builder = "mine",
	floor = {
		"rc_ground_01", 1,
	},
	centerPillar = {
		"mine_moss_pillar_01", 1,
		"mine_moss_pillar_02", 1,
		"mine_moss_pillar_03", 1,
	},
	wall = {
		"fire_moss_wall_01", 1,
	},
	automapTile = "rocky_wall",
}

defineTile{
	name = "fire_cave_lava",
	editorIcon = 192,
	color = {249,55,2,255},
	builder = "dungeon",
	randomFloorFacing = true,
	floor = {
		"rc_molten_floor_01", 1,
	},
	ceiling = {
		"mine_moss_ceiling_01", 1,
		"mine_moss_ceiling_02", 1,
		"mine_moss_ceiling_03", 1,
	},
	wall = {
		"rc_molten_edge_01", 1,
		"rc_molten_edge_02", 1,
	},
	underwater = true,
	automapTile = "water",
}

defineTile{
	name = "fire_cave_wall_stone", -- Stone structural walls, ceiling & pillars only --
	editorIcon = 196,
	color = {122,85,85,255},
	solid = true,
	builder = "mine",
	randomFloorFacing = true,
	floor = {
		"rc_ground_02", 1,
	},
	centerPillar = {
		"rc_pillar_stone", 1,
	},
	wall = {
		"rc_wall_stone", 1,
	},
	automapTile = "rocky_wall",
}

defineTile{
	name = "fire_cave_floor_stoneCeiling",
	editorIcon = 192,
	color = {122,75,75,255},
	builder = "dungeon",
	randomFloorFacing = true,
	floor = {
		"rc_ground_02", 1,
	},
	ceiling = {
		"rc_ceiling_02", 5,
	},
	wall = {
		"rc_elevation_edge_01", 1,
		"rc_elevation_edge_02", 1,
	},
}