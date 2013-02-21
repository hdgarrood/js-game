COFFEE = coffee
SOURCES = src/*.coffee

game.js: $(SOURCES)
	$(COFFEE) --compile --join $@ $(SOURCES)
