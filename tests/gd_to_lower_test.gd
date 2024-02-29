extends SimpleTest

func it_should_convert_whole_string_to_lowercase():
    expect(GD_.to_lower('--Foo-Bar--')).to.equal('--foo-bar--')
    expect(GD_.to_lower('fooBar')).to.equal('foobar')
    expect(GD_.to_lower('__FOO_BAR__')).to.equal('__foo_bar__')

func it_can_be_used_as_an_iterator():
    var input = ['--Foo-Bar--','fooBar','__FOO_BAR__']
    var output = ['--foo-bar--','foobar','__foo_bar__']
    
    var result = GD_.map(input, GD_.to_lower);
    
    expect(result).to.equal(output)
