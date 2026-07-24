class_name AbilityEffect

var name: String
var description: String
var function: Callable

func _init(name, description, function):
	self.name = name
	self.description = description
	self.function = function
