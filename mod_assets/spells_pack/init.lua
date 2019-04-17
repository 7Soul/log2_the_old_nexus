-- Options
path = "mod_assets/spells_pack/" -- The path containing all ressources for the spells pack.
                                 -- If you change it, you must also change it at the beginning of spells_function.lua.
hook_framework = false           -- if you use the Hook framework, set this to true to get compatible hooks.



-- This file must also be set as the source of a script entity in your dungeon with the specific id: spells_functions.
import (path.."spells_functions.lua")
for _,def in pairs(defOrdered) do
	defineSpell(def)
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

-- Required assets for the spells. If you remove a spell from the pack, you can search thoses files and remove the unused assets.
import (path.."conditions.lua")
import (path.."materials.lua")
import (path.."objects.lua")
import (path.."particles.lua")
import (path.."party.lua")
import (path.."skills.lua")
import (path.."sounds.lua")
import (path.."traits.lua")

-- The spellbook.
import (path.."items/spellbook.lua")

-- Redefined items with compatible timer icons gui.
import (path.."items/crystal_shards.lua")
import (path.."items/potions.lua")

-- Custom items used for enchantment spells.
--import (path.."items/containers.lua")
import (path.."items/missile_weapons.lua")
import (path.."items/staves.lua")
import (path.."items/swords.lua")

-- Redefined items with compatible spells power bonuses.
import (path.."items/shaman_staff.lua") -- earth +20%
import (path.."items/zhandul_orb.lua")  -- fire +20%

-- Optional items with added spells power bonuses.
import (path.."items/magic_orb.lua")         -- concentration +20%
import (path.."items/nectarbranch_wand.lua") -- water +20%
import (path.."items/stormseed_orb.lua")     -- air +20%

-- Optional items to test all the spells.
import (path.."items/cheats.lua")

