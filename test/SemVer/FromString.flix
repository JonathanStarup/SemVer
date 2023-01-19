mod Test.SemVer.FromString {

mod Pos {
    use FromString.fromString
    use SemVer.semVer

    def posTest(major: Int32, minor: Int32, patch: Int32): Bool = {
        fromString("${major}.${minor}.${patch}") == semVer(major, minor, patch)
    }

    @Test
    pub def test001(): Bool = posTest(0, 0, 0)

    @Test
    pub def test002(): Bool = posTest(0, 0, 1)

    @Test
    pub def test003(): Bool = posTest(0, 1, 0)

    @Test
    pub def test004(): Bool = posTest(1, 0, 0)

    @Test
    pub def test005(): Bool = posTest(0, 0, 10_402)

    @Test
    pub def test006(): Bool = posTest(0, 10_042, 0)

    @Test
    pub def test007(): Bool = posTest(80_204, 0, 0)

    @Test
    pub def test008(): Bool = posTest(402, 402, 0)

    @Test
    pub def test009(): Bool = posTest(402, 0, 402)

    @Test
    pub def test010(): Bool = posTest(0, 402, 402)

    @Test
    pub def test011(): Bool = posTest(402, 402, 402)

    @Test
    pub def test012(): Bool \ NonDet = {
        let r = Random.newWithSeed(14_924_988i64);
        let next = _ -> Random.nextNatWithMax(r, 1_000_000);
        List.range(0, 5000) |> List.forAll(_ -> {
            posTest(next(), next(), next())
        })
    }

}

mod Neg {
    use FromString.fromString
    use SemVer.semVer

    def negTest(s: String): Bool = {
        fromString(s) == (None: Option[SemVer])
    }

    @Test
    pub def test001(): Bool = negTest("00.0.0")

    @Test
    pub def test002(): Bool = negTest("0.00.0")

    @Test
    pub def test003(): Bool = negTest("0.0.00")

    @Test
    pub def test004(): Bool = negTest("0.0.0.")

    @Test
    pub def test005(): Bool = negTest("1")

    @Test
    pub def test006(): Bool = negTest("1.0")

    @Test
    pub def test007(): Bool = negTest("1.0.0.0")

    @Test
    pub def test008(): Bool = negTest("+1.1.9")

    @Test
    pub def test009(): Bool = negTest("1.+1.9")

    @Test
    pub def test010(): Bool = negTest("1.1.+9")

}
}
