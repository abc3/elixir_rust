.PHONY: bench

init: 
	mix deps.get && mix compile && rustc ./native/port_echo.rs -o ./native/port_echo && docker build -t iex_echo_app .

dev:
	ERL_AFLAGS="-kernel shell_history enabled" iex --name node@127.0.0.1 --cookie cookie -S mix

bench:
	mix run bench/echo.exs

docker_build:
	docker build -t iex_echo_app .

docker_run:
	docker run -it iex_echo_app
