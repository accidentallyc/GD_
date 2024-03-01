## @TODO Reuse tests from lodash repo
extends SimpleTest


var array = [{"id":4}, {"id":5}, {"id":5}, {"id":5}, {"id":6}]
func it_returns_the_index_of_last_occurence():
    expect(GD_.sorted_last_index_by(array, {"id":5}, "id")).to.equal(4)


func it_is_able_to_return_last_index_if_beyond_last():
    expect(GD_.sorted_last_index_by(array, {"id":7}, "id")).to.equal(5)
#
#
func it_is_able_to_return_last_index_if_below_first():
    expect(GD_.sorted_last_index_by(array, {"id":1}, "id")).to.equal(0)
