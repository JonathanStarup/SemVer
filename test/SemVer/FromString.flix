mod Test.SemVer.FromString {

mod Pos {
    use FromString.fromString
    use SemVer.semVer

    def test(major: Int32, minor: Int32, patch: Int32): Bool = {
        fromString("${major}.${minor}.${patch}") == semVer(major, minor, patch)
    }

    @Test
    pub def test001(): Bool = test(0, 0, 0)

    @Test
    pub def test002(): Bool = test(0, 0, 1)

    @Test
    pub def test003(): Bool = test(0, 1, 0)

    @Test
    pub def test004(): Bool = test(1, 0, 0)

    @Test
    pub def test005(): Bool = test(0, 0, 10_402)

    @Test
    pub def test006(): Bool = test(0, 10_042, 0)

    @Test
    pub def test007(): Bool = test(80_204, 0, 0)

    @Test
    pub def test008(): Bool = test(402, 402, 0)

    @Test
    pub def test009(): Bool = test(402, 0, 402)

    @Test
    pub def test010(): Bool = test(0, 402, 402)

    @Test
    pub def test011(): Bool = test(402, 402, 402)

    @Test
    pub def test012(): Bool \ NonDet = {
        let r = Random.newWithSeed(14_924_988i64);
        let next = _ -> Random.nextNatWithMax(r, 1_000_000);
        List.range(0, 5000) |> List.forAll(_ -> {
            test(next(), next(), next())
        })
    }

}

mod Neg {
    use FromString.fromString
    use SemVer.semVer

    def test(s: String): Bool = {
        fromString(s) == (None: Option[SemVer])
    }

    @Test
    pub def test001(): Bool = test("00.0.0")

    @Test
    pub def test002(): Bool = test("0.00.0")

    @Test
    pub def test003(): Bool = test("0.0.00")

    @Test
    pub def test004(): Bool = test("0.0.0.")

    @Test
    pub def test005(): Bool = test("1")

    @Test
    pub def test006(): Bool = test("1.0")

    @Test
    pub def test007(): Bool = test("1.0.0.0")

    @Test
    pub def test008(): Bool = test("+1.1.9")

    @Test
    pub def test009(): Bool = test("1.+1.9")

    @Test
    pub def test010(): Bool = test("1.1.+9")

}
}
