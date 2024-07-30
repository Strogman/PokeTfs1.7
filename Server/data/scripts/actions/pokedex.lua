local doPokedex = Action()

function doPokedex.onUse(player, item, fromPosition, target, toPosition, isHotkey, returnPokemon)
	if type(target) == "userdata" and (target ~= player or not target:isPokemon()) then
		return false
	end
	
	if target:isPokemon() then
		local pokeName = target:getName()
		if not player:getPokeInDex(pokeName) then
			return player:doRegisterPokeInDex(pokeName)
		end

		return player:doShowPokeInDex(pokeName)
	end

	return player:doShowPokeDex()
end


doPokedex:id(12160)
doPokedex:register()
