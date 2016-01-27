REBAR=`which rebar`
DIALYZER=dialyzer

all: get-deps compile

get-deps:
	@$(REBAR) get-deps

compile:
	@$(REBAR) compile

clean:
	@$(REBAR) clean

eunit:
	@$(REBAR) skip_deps=true eunit

ct:
	@$(REBAR) skip_deps=true ct

tests: eunit ct

rel: deps compile
	@$(REBAR) generate

relclean:
	@rm -rf rel/erlasticsearch

build-plt:
	@$(DIALYZER) --build_plt --output_plt .erlastic_dialyzer.plt \
		--apps kernel stdlib sasl #misultin emysql

dialyze:
	@$(DIALYZER) --src src --plt .erlastic_dialyzer.plt -Werror_handling \
		-Wrace_conditions -Wunmatched_returns # -Wunderspecs

docs:
	@$(REBAR) skip_deps=true doc
