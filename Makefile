.PHONY: bench

init: 
	mix compile && rustc ./native/port_echo.rs -o ./native/port_echo

dev:
	ERL_AFLAGS="-kernel shell_history enabled" iex --name node@127.0.0.1 --cookie cookie -S mix

bench:
	mix run bench/echo.exs
