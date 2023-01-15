OPT = -O3 -march=native
# OPT = -march=rv64imafdc -mabi=lp64d -mcpu=sifive-u74
EXE = math_bench

all:
	fypp -m bench src/main.fypp          > artifacts/main.f90
	fypp -m bench src/bench_real.fypp    > artifacts/bench_real.f90
	fypp -m bench src/bench_integer.fypp > artifacts/bench_integer.f90
	gfortran -ffree-line-length-none src/benchmark.f90 artifacts/bench_integer.f90 artifacts/bench_real.f90 artifacts/main.f90 $(OPT) -o $(EXE)
	rm *.mod
