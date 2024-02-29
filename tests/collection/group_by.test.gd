## @TODO Reuse tests from lodash repo
extends SimpleTest


var barney = { 'user': 'barney',  'age': 36, 'active': true, 'gender':'m' }
var fred = { 'user': 'fred',    'age': 40, 'active': false, 'gender':'m' }
var pebbles = { 'user': 'pebbles', 'age': 1,  'active': true , 'gender':'f' }
var users = [barney,fred,pebbles];

func it_groups_using_truthiness():
    var collection = ["foo",0,"",null,1,null,"1","foo",null]
    var result = GD_.group_by(collection)
    expect(result).to.equal({
                "":[""],
                "0":[0],
                "1":[1,"1"],
                "foo": ["foo","foo"],
                "<null>":[null,null,null],
            })


func it_groups_using_lambda():
    var result = GD_.group_by(users, func(u, _u): return u.user)
    expect(result).to.equal({
        "barney": [barney],
        "fred": [fred],
        "pebbles":[pebbles]
    })


func it_groups_by_using_matches_shorthand():
    var result = GD_.group_by(users, { 'gender': 'm', 'active': true })
    expect(result).to.equal({
        "true": [barney],
        "false": [fred,pebbles]
    })


func it_groups_by_using_matches_property_shorthand():
    var result = GD_.group_by(users, ['active', false])
    expect(result).to.equal({
        "true": [fred],
        "false": [barney, pebbles]
    })


func it_groups_by_using_property_shorthand():
    var result = GD_.group_by(users, 'active')
    expect(result).to.equal({
        "true": [barney, pebbles],
        "false": [fred],
    })
