## Benchmark of echo functions from erlang port and nif via the [rustler](https://github.com/rusterlium/rustler) lib

```
$ make init && make bench
mix run bench/echo.exs
Operating System: macOS
CPU Information: Apple M1 Pro
Number of Available Cores: 10
Available memory: 16 GB
Elixir 1.14.0
Erlang 25.0.3

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
inputs: none specified
Estimated total run time: 14 s

Benchmarking port echo ...
Benchmarking rustler echo ...

Name                   ips        average  deviation         median         99th %
elixir echo        25.45 M      0.0393 μs ±30595.73%      0.0420 μs      0.0420 μs
rustler echo        5.94 M       0.168 μs ±16054.07%       0.125 μs        0.25 μs
port echo          0.124 M        8.05 μs   ±132.95%        6.96 μs       20.71 μs
docker echo      0.00428 M      233.40 μs    ±34.33%      236.75 μs      340.09 μs

Comparison:
elixir echo        25.45 M
rustler echo        5.94 M - 4.28x slower +0.129 μs
port echo          0.124 M - 204.87x slower +8.01 μs
docker echo      0.00428 M - 5939.67x slower +233.36 μs
```
