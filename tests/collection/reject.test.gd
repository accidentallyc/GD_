extends SimpleTest

var barney = { 'user': 'barney', 'age': 36, 'active': false }
var fred = { 'user': 'fred',   'age': 40, 'active': true }
var users = [ barney, fred ]
func it_returns_all_rejected_elements():
    var result
    var not_active = func (o, i): 
        return !o.active
        
    result = GD_.reject(users, not_active)
    expect(result).to.equal([fred])
     
    # The `GD_.matches` iteratee shorthand.
    result = GD_.reject(users, { 'age': 40, 'active': true })
    expect(result).to.equal([barney], "Failed at matches iteratee")
     #
    result = GD_.reject(users,  ['active', false])
    expect(result).to.equal([fred], "Failed at matches_property iteratee")
    
    result = GD_.reject(users, 'active');
    expect(result).to.equal([barney], "Failed at property iteratee")
