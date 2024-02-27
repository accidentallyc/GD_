## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_generates_unique_ids():
    # For the test to be consistent we need to reset the counter
    var original_ctr = GD_.__INTERNAL__.id_ctr
    GD_.__INTERNAL__.id_ctr = 0
    
    expect(GD_.unique_id()).to.equal(1)
    expect(GD_.unique_id('FOO')).to.equal('FOO2')
    expect(GD_.unique_id('BAR_')).to.equal('BAR_3')
    
    GD_.__INTERNAL__.id_ctr += original_ctr
