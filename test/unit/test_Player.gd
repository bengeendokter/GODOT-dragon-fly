extends 'res://addons/gut/test.gd'

func test_some_method():
	var expected_result = 10
	var result = 10
	
	assert_eq(result, expected_result, "Result shoud have been %d" % expected_result)
