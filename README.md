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
rustler echo        1.37 M        0.73 μs  ±2009.59%        0.71 μs        0.83 μs
port echo          0.136 M        7.34 μs    ±58.42%        6.92 μs       11.92 μs

Comparison:
rustler echo        1.37 M
port echo          0.136 M - 10.08x slower +6.61 μs
```
