extends SimpleTest


func it_should_convert_whole_string_to_uppercase():
    expect(GD_.to_upper('--Foo-Bar')).to.equal('--FOO-BAR');
    expect(GD_.to_upper('fooBar')).to.equal('FOOBAR');
    expect(GD_.to_upper('__FOO_BAR__')).to.equal('__FOO_BAR__');

func it_should_be_usable_in_map():
    var input = ['–Foo-Bar', 'fooBar', 'FOO_BAR']
    var output =['–FOO-BAR', 'FOOBAR', 'FOO_BAR']
    var result = GD_.map(input, GD_.to_upper) 
    expect(result).to.equal(output)
