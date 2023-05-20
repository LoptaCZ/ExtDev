local ammo={
	name="acf_sniper",
	dmgtype=DMG_BULLET,
	plydmg=150,
	npcdmg=150,
	force=2000,
	minsplash=10,
	maxsplash=5
}
game.AddAmmoType(ammo)

local ammo={
	name="acf_xm25",
	dmgtype=DMG_BULLET,
	plydmg=200,
	npcdmg=200,
	force=500,
	minsplash=10,
	maxsplash=5
}
game.AddAmmoType(ammo)

local ammo={
	name="csgo_5.56x45mm",
	dmgtype=DMG_BULLET,
	plydmg=13,
	npcdmg=13,
	force=200,
	minsplash=10,
	maxsplash=5
}
game.AddAmmoType(ammo)//M4A1(-S), FAMAS, Galil AR, AUG, SG 553, M249, Negev

local ammo={
	name="csgo_.45_acp",
	dmgtype=DMG_BULLET,
	plydmg=13,
	npcdmg=13,
	force=200,
	minsplash=10,
	maxsplash=5
}
game.AddAmmoType(ammo)//USP-S, MAC-10, UMP-45

local ammo={
	name="csgo_9mm_parabellum",
	dmgtype=DMG_BULLET,
	plydmg=13,
	npcdmg=13,
	force=200,
	minsplash=10,
	maxsplash=5
}
game.AddAmmoType(ammo)//Glock-18, Tec-9, CZ75-Auto, Dual Berettas, MP9, PP-Bizon, MP7, MP5-SD

local ammo={
	name="csgo_.357_sig",
	dmgtype=DMG_BULLET,
	plydmg=13,
	npcdmg=13,
	force=200,
	minsplash=10,
	maxsplash=5
}

game.AddAmmoType(ammo)//P250

local ammo={
	name="csgo_5.7x28mm",
	dmgtype=DMG_BULLET,
	plydmg=13,
	npcdmg=13,
	force=200,
	minsplash=10,
	maxsplash=5
}
game.AddAmmoType(ammo)//Five-SeveN, P90

local ammo={
	name="csgo_.50_action_express",
	dmgtype=DMG_BULLET,
	plydmg=13,
	npcdmg=13,
	force=200,
	minsplash=10,
	maxsplash=5
}
game.AddAmmoType(ammo)//Desert Eagle, R8 Revolver

local ammo={
	name="csgo_7.62",
	dmgtype=DMG_BULLET,
	plydmg=13,
	npcdmg=13,
	force=200,
	minsplash=10,
	maxsplash=5
}
game.AddAmmoType(ammo)//AK-47, SSG 08, SCAR-20, G3SG1

local ammo={
	name="csgo_.338_lapua_magnum",
	dmgtype=DMG_BULLET,
	plydmg=13,
	npcdmg=13,
	force=200,
	minsplash=10,
	maxsplash=5
}
game.AddAmmoType(ammo)//AWP

local ammo={
	name="csgo_12gauge",
	dmgtype=DMG_BULLET,
	plydmg=19,
	npcdmg=13,
	force=200,
	minsplash=10,
	maxsplash=5
}
game.AddAmmoType(ammo)//Nova, XM1014, MAG-7, Sawed-Off
if CLIENT then
	language.Add("acf_sniper_ammo","ACF Sniper Round")
	language.Add("acf_xm25_ammo","ACF XM25 Magazine")
	
	language.Add("csgo_5.56x45mm_ammo","5.56x45mm Magazine")
	language.Add("csgo_.45_acp_ammo",".45 ACP Magazine")
	language.Add("csgo_9mm_parabellum_ammo","9mm Parabellum Magazine")
	language.Add("csgo_.357_sig_ammo",".357 Sig Magazine")
	language.Add("csgo_5.7x28mm_ammo","5.7x28mm Magazine")
	language.Add("csgo_.50_action_express_ammo",".50 Action express Magazine")
	language.Add("csgo_7.62_ammo","7.62 Magazine")
	language.Add("csgo_.338_lapua_magnum_ammo",".338 Lapua Magnum Magazine")
	language.Add("csgo_12gauge_ammo","12Gauge Shotgun Shells")
end