INTEGER_PRECISION   = ['1', '2', '4', '8', '16']

INTEGER_HANDS       = ['add_v1', 'add_v2', 'add_v3', 'mul_v1', 'mul_v2', 'mul_v3', 'fma_v1', 'fma_v2', 'fma_v3', 'fma_v4', 'div_v1', 'div_v2', 'inv_v1', 'inv_v2.1', 'inv_v2.2', 'inv_v2.3']
INTEGER_INTRINSICS  = ['popcnt', 'poppar']
INTEGER_INTRINSICS2 = ['dim', 'iand', 'ieor', 'ior', 'ishft', 'ishftc', 'ibset', 'ibclr', 'min', 'max', 'shifta', 'shiftl', 'shiftr']

REAL_PRECISION      = ['4', '8', '16']

REAL_HANDS          = ['add_v1', 'add_v2', 'add_v3', 'mul_v1', 'mul_v2', 'mul_v3', 'fma_v1', 'fma_v2', 'fma_v3', 'fma_v4', 'div_v1', 'div_v2', 'inv', 'invsqrt_v1', 'invsqrt_v2']
REAL_INTRINSICS     = ['exp', 'erf', 'erfc', 'erfc_scaled', 'gamma', 'sqrt', 'sin', 'cos', 'tan', 'sinh', 'cosh', 'tanh', 'asinh', 'acosh', 'atan', 'bessel_j0', 'bessel_j1', 'bessel_y0', 'bessel_y1', 'epsilon', 'exponent', 'fraction', 'log', 'log10', 'log_gamma']
REAL_INTRINSICS2    = ['atan2', 'dim']

BENCHMARK_LEN = len(INTEGER_PRECISION) * (len(INTEGER_HANDS) + len(INTEGER_INTRINSICS) + len(INTEGER_INTRINSICS2)) + \
                len(REAL_PRECISION) * (len(REAL_HANDS) + len(REAL_INTRINSICS) + len(REAL_INTRINSICS2))

CACHE_USAGE = 4 # in Kb

REPEATS     = 100000
MAX_STEPS   = 10
PROGRESS    = ".true."