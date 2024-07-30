// Copyright 2023 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#ifndef FS_POKEBALL_H
#define FS_POKEBALL_H

#include "item.h"

class PokeBall final : public Item
{
public:
	explicit PokeBall(uint16_t id);

	PokeBall* getPokeBall() override { return this; }
	const PokeBall* getPokeBall() const override { return this; }

	void setName(std::string _name) {name = _name;}
	void setNick(std::string _nick) {nick = _nick;}
	void setHealth(int32_t _health) { health = _health; }
	void setMaxHealth(int32_t _maxHealth) { maxHealth = _maxHealth; }

	std::string getName() {return name;}
	std::string getNick() {return nick;}
	int32_t getHealth() {return health;}
	int32_t getMaxHealth() {return maxHealth;}

	void setState(uint8_t _state) {state = _state;}
	uint8_t getState() {return state;}

private:
	std::string name, nick;
	int32_t health, maxHealth;
	uint8_t state;
};

#endif // FS_POKEBALL_H
