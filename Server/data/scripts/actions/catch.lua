local catch = Action()

function catch.onUse(player, item, fromPosition, pokemon, toPosition, isHotkey, returnPokemon)
	if type(pokemon) == "userdata" and not pokemon:isItem() then
		return false
	end
	
	if pokemon:isCatchable() then
	  if item:getBallType() ~= SAFFARIBALL and player:isSaffari() then
		doPlayerSendCancel(cid, "You can only play pokeballs from saffari on pokemon.")
		return true
	  end
	
	  --local pokeName = pokemon:getPokeName()
	  local catchChance = pokemon:getPokeChance()*item:getCatchChance()
	  local randomCatch = math.random(1, MAX_CATCHCHANCE)
	  local catchStatus = false
	  if randomCatch <= catchChance then
	  	catchStatus = true
		--fromPosition:sendDistanceEffect(toPosition, item:getCatchDistanceEffect())
		--toPosition:sendMagicEffect(item:getCatchEffect())
		--player:addCaughtPoke(item:getBallType(), pokeName, pokemon:isShiny())
	  end
	  --else
		--fromPosition:sendDistanceEffect(toPosition, item:getCatchDistanceEffect())
		--toPosition:sendMagicEffect(item:getCatchEffectFail())
		--player:addFailCaughtPoke(item:getBallType(), pokeName, pokemon:isShiny())
	  -- end
	  player:addCaughtPoke(item, pokemon, catchStatus)
	  
	  --player:removeItem(item.itemId, 1)
	  
	  if player:isSaffari() and player:getCountBallById(SAFFARIBALL) <= 0 then
        player:exitSaffari()
		--player:teleportTo(SafariOut)
		--player:getPosition():sendMagicEffect(21)
		--player:sendTextMessage(27, "You spend all your saffari balls, good luck in the next time...")
      end
	  
	end

	return true
end

local pokeballs = Game.getCaughtBalls()
for index, pokeball in pairs(pokeballs) do
	catch:id(pokeball.itemType)
end

catch:register()
