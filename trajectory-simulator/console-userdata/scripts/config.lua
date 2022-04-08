ndim = 3
tps_mult = 10
scale = 10

bodies = {
    new_body(
        "star", 10000,
        { 0, 0, 0 },
        { 0, 0, 0 }
    ),
    new_body(
        "planet", 100,
        { 100, 100, 0 },
        { 0, -10, 0 }
    )
}
