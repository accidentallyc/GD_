extends SimpleTest

func it_should_lowercase_as_space_separated_words():
    expect(GD_.lower_case('--Foo-Bar--')).to.equal('foo bar')
    expect(GD_.lower_case('fooBar')).to.equal('foo bar')
    expect(GD_.lower_case('__FOO_BAR__')).to.equal('foo bar')
    expect(GD_.lower_case('aaAaAaA')).to.equal('aa aa aa a')
