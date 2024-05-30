extends SimpleTest

func it_correctly_finds_keys_in_dictionaries():
    var users = {
        'barney':  { 'age': 36, 'active': true },
        'fred':    { 'age': 40, 'active': false },
        'pebbles': { 'age': 1,  'active': true }
    }
    
    var result = GD_.find_last_key(users, func(o, _o): return o.age < 40 )
    expect(result).to.equal('pebbles')
    
    result = GD_.find_last_key(users, { 'age': 36, 'active': true })
    expect(result).to.equal('barney')
    
    result = GD_.find_last_key(users, ['active', false])
    expect(result).to.equal('fred')
    
    result = GD_.find_last_key(users, 'active')
    expect(result).to.equal('pebbles')
