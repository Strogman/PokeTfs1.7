local doGoback = Action()

function doGoback.onUse(player, item, fromPosition, target, toPosition, isHotkey, returnPokemon)
	if player:getPokemon() then
		if not player:doReturnPokemon(returnPokemon) then
			player:sendCancelMessage("Invalid return pokemon.")
			return false
		end
	end

	return player:doGoPokemon(item)
end

local pokeballs = Game.getPokeBalls()
for index, pokeball in pairs(pokeballs) do
	doGoback:id(pokeball.itemType)
end

doGoback:register()
