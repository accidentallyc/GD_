extends SimpleTest

func it_can_correctly_check_godot_version_number():
	GD_.__INTERNAL__.engine_version.major = 4
	GD_.__INTERNAL__.engine_version.minor = 3
	
	# Integer with Minor
	expect(GD_.is_version(4.3)).to.be.truthy('Should match 4.3')
	expect(GD_.is_version(4.2)).to.be.falsey('Should fail 4.2')
	
	# Strings
	expect(GD_.is_version("4.3")).to.be.truthy('Should default to ==')
	expect(GD_.is_version("=4.3")).to.be.truthy('Should be same as just setting 4')
	expect(GD_.is_version("==4.3")).to.be.truthy('Should same as =4')
	
	expect(GD_.is_version(">4")).to.be.truthy('Should be true cause >4')
	expect(GD_.is_version(">4.3")).to.be.falsey('Should be true cause >=4')
	expect(GD_.is_version(">=4.3")).to.be.truthy('Should be true cause >=4')
	
	expect(GD_.is_version("<5")).to.be.truthy('Should be true cause >=4')
	expect(GD_.is_version("<4.3")).to.be.falsey('Should be true cause >=4')
	expect(GD_.is_version("<=4.3")).to.be.truthy('Should be true cause >=4')
	
	GD_.__INTERNAL__.engine_version = Engine.get_version_info()
