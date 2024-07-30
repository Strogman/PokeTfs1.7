CONST_BALL_IS_ON = 1
CONST_BALL_IS_USING = 2
CONST_BALL_IS_OFF = 3

function Player.returnPokemon(slotBall)
	local pokemon = self:getPokemon()
	if slotBall:getBallState() == CONST_BALL_IS_USING then
		if not pokemon then
			self:sendCancelMessage("Your Pokémon is tired")
			slotBall:setPokeHealth(0)
			slotBall:setBallState(CONST_BALL_IS_OFF)
			return false
		end

		pokemon:getPosition():sendMagicEffect(slotBall:getBallEffect())
		slotBall:setPokeHealth(pokemon:getHealth())
		slotBall:setBallState(CONST_BALL_IS_ON)
		Game.removeCreature(pokemon, false)
		return true
	end

	return false
end

function Player.goPokemon(slotBall)
	if slotBall:getBallState() == CONST_BALL_IS_OFF then
		self:sendCancelMessage("Your Pokémon is tired")
		return false
	end

	if slotBall:getBallState() == CONST_BALL_IS_ON then
		local monster = Game.createMonster(slotBall:getPokeName(), self:getPosition())

		local hp = slotBall:getPokeHealth()
		if hp < 1 then
			self:sendCancelMessage("Your Pokémon is tired")
			slotBall:setBallState(CONST_BALL_IS_OFF)
			return false
		end

		monster:setHealth(hp)

		if hp > monster:getMaxHealth() then
			monster:setMaxHealth(hp)
		end

		self:addSummon(monster)
		slotBall:setBallState(CONST_BALL_IS_USING)
		monster:getPosition():sendMagicEffect(slotBall->getBallEffect())

		return true
	end
	return false
end

local goback = Action()

function goback.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getSlotItem(CONST_SLOT_FEET) == item then
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
