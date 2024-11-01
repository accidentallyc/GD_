extends SimpleTest

func it_can_correctly_check_godot_version_number():
    GD_.__INTERNAL__.engine_version.major = 4
    GD_.__INTERNAL__.engine_version.minor = 3
    GD_.__INTERNAL__.is_version_cache = {}
    
    var ver_num:float = 4.3
    
    # Integer with Minor
    expect(GD_.is_version(4.3)).to.be.truthy('%s == 4.3' % ver_num)
    expect(GD_.is_version(4.2)).to.be.falsey('%s != 4.2' % ver_num)
    
    # Strings
    expect(GD_.is_version("4.3")).to.be.truthy("'%s' == 4.3" % ver_num)
    expect(GD_.is_version("=4.3")).to.be.truthy('%s = 4.3' % ver_num)
    expect(GD_.is_version("==4.3")).to.be.truthy('%s == 4.3' %ver_num)
    
    expect(GD_.is_version(">4")).to.be.truthy('%s >4' % ver_num)
    expect(GD_.is_version(">4.3")).to.be.falsey('%s >=4' % ver_num)
    expect(GD_.is_version(">=4.3")).to.be.truthy('%s >=4' % ver_num)
    
    expect(GD_.is_version("<5")).to.be.truthy('%s < 5' % ver_num)
    expect(GD_.is_version("<4.3")).to.be.falsey('%s < 4.3' % ver_num)
    expect(GD_.is_version("<=4.3")).to.be.truthy('%s <= 4.3' % ver_num)
    
    GD_.__INTERNAL__.engine_version = Engine.get_version_info()
    GD_.__INTERNAL__.is_version_cache = {}
