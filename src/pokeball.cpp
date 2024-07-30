// Copyright 2023 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "otpch.h"

#include "pokeball.h"

#include "condition.h"
#include "game.h"
#include "iologindata.h"
#include "scheduler.h"

extern Game g_game;

PokeBall::PokeBall(uint16_t id) : Item(id) { 
	name = nick = "";
	health = maxHealth = 100;
	state = 1;
}