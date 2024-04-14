## @TODO Reuse tests from lodash repo
extends SimpleTest

var object = { 'a': 1 };
var other = { 'a': 1 };

func it_acts_same_as_equal():
    expect(GD_.eq(object, object)).to.be.truthy('Failed at object-other')
    expect(GD_.eq(object, other)).to.be.truthy('Failed at other-object')
    expect(GD_.eq('a', 'a')).to.be.truthy('Failed at str-str')
    expect(GD_.eq('a', &'a')).to.be.truthy('Failed at str-strName')
    expect(GD_.eq(1,1)).to.be.truthy('Failed at int-int')
    expect(GD_.eq(1.0,1)).to.be.truthy('Failed at float-int')
    
func it_is_type_safe():
    expect(GD_.eq([1,2,34],'foobar')).to.be.falsey()
    expect(GD_.eq([1,2,34],{"red":2})).to.be.falsey()
