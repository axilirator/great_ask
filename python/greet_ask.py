#!/usr/bin/env python
# -*- coding: utf-8 -*-

class Greetings:
	def __init__(self, hallo_str):
		self._hallo_str = hallo_str

	def say_hallo(self, name):
		return "%s, %s!" % (self._hallo_str, name)

class Questions(Greetings):
	def ask_question(self, name, question):
		return "%s %s?" % (self.say_hallo(name), question)

# Demo!
if __name__ == '__main__':
	qde = Questions("Mahlzeit")
	qen = Questions("Hello")

	# Check the "inherited" functionality
	print(qde.say_hallo("Max"))
	print(qen.say_hallo("Max"))

	print(qde.ask_question("Max", "Wie geht's"))
	print(qen.ask_question("Max", "How are you"))
