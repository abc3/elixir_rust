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

Name                        ips        average  deviation         median         99th %
elixir echo         121768.47 K     0.00821 μs ±44955.52%     0.00830 μs      0.0208 μs
rustler echo          5639.88 K       0.177 μs ±15245.17%       0.125 μs        0.25 μs
port echo              131.42 K        7.61 μs    ±75.05%           7 μs       12.79 μs
docker tcp socket        8.64 K      115.71 μs    ±19.07%      112.58 μs      175.71 μs
docker echo              4.16 K      240.56 μs    ±12.14%      238.17 μs      315.61 μs

Comparison:
elixir echo         121768.47 K
rustler echo          5639.88 K - 21.59x slower +0.169 μs
port echo              131.42 K - 926.57x slower +7.60 μs
docker tcp socket        8.64 K - 14089.52x slower +115.70 μs
docker echo              4.16 K - 29292.60x slower +240.55 μs
```
