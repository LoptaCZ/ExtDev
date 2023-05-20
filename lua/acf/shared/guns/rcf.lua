--define the class
ACF_defineGunClass("RCF", {
	spread = 0.14,
	name = "Russian Combat Framework",
	desc = "This is a category that i have created for some OP guns, enjoy the stalinium.",
	muzzleflash = "120mm_muzzleflash_noscale",
	rofmod = 1.3,
	sound = "acf_extra/tankfx/gnomefather/107mm1.wav",
	soundDistance = "Cannon.Fire",
	soundNormal = " "
} )

ACF_defineGun("213mmHW", {
	name = "213mm Howitzer",
	desc = "Blyatmachine that shoots ammo that is big like your car.",
	model = "models/howitzer/howitzer_203mm.mdl",
	gunclass = "RCF",
	caliber = 40.3,
	weight = 10280,
	year = 1993,
	round = {
		maxlength = 162.4,
		propweight = 28.5
	}
} )

ACF_defineGun("150mmSC", {
	name = "150mm Tsar Launcher",
	desc = "Do you remember KV-2 ? This is the cannon you will love.",
	model = "models/tankgun/tankgun_short_140mm.mdl",
	gunclass = "RCF",
	caliber = 50.0,
	weight = 8040,
	year = 1939,
	round = {
		maxlength = 127,
		propweight = 12.8
	}
} )

ACF_defineGun("25mmMG", {
	name = "25mm Machinegun",
	desc = "This Machinegun was so big it is not on any russian bias tank, but someone used it at ships.",
	model = "models/machinegun/machinegun_20mm.mdl",
	gunclass = "RCF",
	caliber = 15.0,
	weight = 54,
	year = 1945,
	rofmod = 0.55,
	magsize = 100,
	magreload = 4,
	round = {
		maxlength = 50,
		propweight = 0.05
	}
} )

ACF_defineGun("84.5mmC", {
	name = "84.5mm Cannon",
	desc = "You want a cannon right? This one is half-good half-shit, it's not that bad.",
	model = "models/tankgun/tankgun_75mm.mdl",
	gunclass = "RCF",
	caliber = 26.0,
	weight = 765,
	year = 1957,
	sound = "weapons/ACF_Gun/ac_fire4.wav",
	round = {
		maxlength = 63,
		propweight = 2.1
	}
} )
