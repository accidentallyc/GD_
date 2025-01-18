extends SimpleTest

func greet(greeting, first_name, statement):
	return "%s %s! %s?" % [greeting,first_name,statement]

	
func it_can_run_the_basic_example():
	var new_callable = GD_.bind(greet,"Greetings")
	var result = new_callable.call("Fred","How are you")
	expect(result).to.equal("Greetings Fred! How are you?")

func it_can_use_placeholders():
	var new_callable = GD_.bind(greet,"Hello", GD_, "Watcha doing")
	var result = new_callable.call("friend")
	expect(result).to.equal("Hello friend! Watcha doing?")
