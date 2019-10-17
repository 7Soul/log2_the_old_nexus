-- Options
path = "mod_assets/spells_pack/" -- The path containing all ressources for the spells pack.
                                 -- If you change it, you must also change it at the beginning of spells_function.lua.
hook_framework = false           -- if you use the Hook framework, set this to true to get compatible hooks.



-- This file must also be set as the source of a script entity in your dungeon with the specific id: spells_functions.
import (path.."spells_functions.lua")
for _,def in pairs(defOrdered) do
	defineSpell(def)
	if (def.hidden ~= nil and def.hidden ~= true) or def.hidden == nil then
		defineObject{
			name = "scroll_"..def.name,
			baseObject = "base_item",
			components = {
				{
					class = "Model",
					model = "assets/models/items/scroll_spell.fbx",
				},
				{
					class = "Item",
					uiName = "Scroll of "..def.uiName,
					gfxIndex = 113,
					weight = 0.03,
					traits = { "spell_scroll" },
				},
				{
					class = "SpellScrollItem",
					spell = def.name,
				},
			},
		}
	end
end

-- Required assets for the spells. If you remove a spell from the pack, you can search thoses files and remove the unused assets.
import (path.."conditions.lua")
import (path.."materials.lua")
import (path.."objects.lua")
-- import (path.."particles.lua")
import (path.."party.lua")
import (path.."skills.lua")
-- import (path.."sounds.lua")
import (path.."traits.lua")