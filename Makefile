# See LICENSE for licensing information.

REBAR = rebar

all: compile

compile: deps
	@$(REBAR) compile

deps:
	@$(REBAR) get-deps

clean:
	@$(REBAR) clean
	rm -f erl_crash.dump
	rm -f doc/*.html doc/*.png doc/edoc-info doc/*.css

distclean: clean
	rm -rf deps

docs:
	@$(REBAR) doc skip_deps=true
