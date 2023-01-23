mod Test.SemVer.SemVer {

mod Pos {
    use SemVer.getMajor
    use SemVer.getMinor
    use SemVer.getPatch
    use SemVer.semVer

    def test(major: Int32, minor: Int32, patch: Int32): Bool = {
        match semVer(major, minor, patch) {
            case None => false
            case Some(v) =>
                getMajor(v) == major and
                getMinor(v) == minor and
                getPatch(v) == patch
        }
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
    pub def test005(): Bool = test(0, 1, 1)

    @Test
    pub def test006(): Bool = test(1, 0, 1)

    @Test
    pub def test007(): Bool = test(1, 1, 0)

    @Test
    pub def test008(): Bool = test(1, 1, 1)

    @Test
    pub def test009(): Bool = test(0, 0, 103_301)

    @Test
    pub def test010(): Bool = test(0, 902_001, 0)

    @Test
    pub def test011(): Bool = test(999_000, 0, 0)

    @Test
    pub def test012(): Bool = test(0, 123_010, 872_001)

    @Test
    pub def test013(): Bool = test(123_321, 0, 987_010)

    @Test
    pub def test014(): Bool = test(101_312, 900_000, 0)

    @Test
    pub def test015(): Bool = test(638_482, 182_801, 900_010)

}

mod Neg {
    use SemVer.getMajor
    use SemVer.getMinor
    use SemVer.getPatch
    use SemVer.semVer

    def test(major: Int32, minor: Int32, patch: Int32): Bool = {
        semVer(major, minor, patch) == None
    }

    @Test
    pub def test001(): Bool = test(0, 0, -1)

    @Test
    pub def test002(): Bool = test(0, -1, 0)

    @Test
    pub def test003(): Bool = test(-1, 0, 0)

    @Test
    pub def test004(): Bool = test(0, -1, -1)

    @Test
    pub def test005(): Bool = test(-1, 0, -1)

    @Test
    pub def test006(): Bool = test(-1, -1, 0)

    @Test
    pub def test007(): Bool = test(-1, -1, -1)

}
}
