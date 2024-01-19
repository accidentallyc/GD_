## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_generates_unique_ids():
	expect(GD_.unique_id()).to.equal(1)
	expect(GD_.unique_id('FOO')).to.equal('FOO2')
	expect(GD_.unique_id('BAR_')).to.equal('BAR_3')
