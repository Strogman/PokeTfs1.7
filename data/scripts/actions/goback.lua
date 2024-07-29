local goback = Action()
BALLON = 1
BALLUSING = 2
BALLLOSER = 3
function Player.returnPokemon(slotBall)
	local pokemon = self:getPokemon()
	if slotBall:getBallState() == BALLUSING then
		if not pokemon then 
			self:sendCancelMessage("Your Pokémon is tired")
			slotBall:setPokeHealth(0)
			slotBall:setBallState(BALLLOSER)
			return false 
		end
		
		pokemon:getPosition():sendMagicEffect(slotBall:getBallEffect())
		slotBall:setPokeHealth(pokemon:getHealth())
		slotBall:setBallState(BALLON)
		Game.removeCreature(pokemon, false)
		return true
	end
	
	return false
end
function Player.goPokemon(slotBall)
	if slotBall:getBallState() == BALLLOSER then 
		self:sendCancelMessage("Your Pokémon is tired")
		return false
	end
	if slotBall:getBallState() == BALLON then 
		local monster = Game.createMonster(slotBall:getPokeName(), self:getPosition())
		local hp = slotBall:getPokeHealth()
		if hp < 1 then 
			self:sendCancelMessage("Your Pokémon is tired")
			slotBall:setBallState(BALLLOSER)
			return false 
		end
		monster:setHealth(hp)
		if hp > monster:getMaxHealth() then
			monster:setMaxHealth(hp)
		end
		self:addSummon(monster)
		slotBall:setBallState(BALLUSING)
		monster:getPosition():sendMagicEffect(slotBall->getBallEffect())
		return true
	end
	return false
end
function goback.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getSlotItem(8) == item then
	  	if player:getPokemon() then
		  	return player:returnPokemon(item)
	  	end
	  
	 	return player:goPokemon(item)
	end

	return true
end

local pokeballs = Game.getPokeBalls()
for index, pokeball in pairs(pokeballs) do
	goback:id(pokeball.itemType)
end

goback:register()
