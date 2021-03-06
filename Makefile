APP_NAME=curly
VSN=0.1

all: compile

compile:
	mkdir -p ebintest
	erl -make

test: compile
	erl -noshell -pa ebin -pa ebintest \
		-s curly_scanner_tests test \
		-s curly_parser_tests test \
		-s curly_tests test \
		-s curly_renderer_tests test \
		-s init stop

docs:
	erl -noshell -run edoc_run application "'$(APP_NAME)'" \
		  '"."' '[{def,{vsn,"$(VSN)"}}]'
