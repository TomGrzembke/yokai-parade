extends Node
class_name State


var context
var previous_state


func init(p_context):
	context = p_context


func enter(p_previous_state):
	previous_state = p_previous_state
	return null


func exit():
	return null


func process(_delta):
	return null


func physics_process(_delta):
	return null


func unhandled_input(_event):
	return null


func input(_event):
	return null
