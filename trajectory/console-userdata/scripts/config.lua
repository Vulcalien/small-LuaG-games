ndim = 2
tps_mult = 10
scale = 10

bodies = {
    new_body(
        "star", 0,
        10000,
        { 0, 0 },
        { 0, 0 }
    ),
    new_body(
        "planet", 1,
        100,
        { 100, 0 },
        { 0, 26 }
    )
}
