mod Test.SemVer.Order {
use SemVer.semVer

@Test
pub def test001(): Bool = semVer(0, 0, 0) == semVer(0, 0, 0)

@Test
pub def test002(): Bool = semVer(0, 0, 1) > semVer(0, 0, 0)

@Test
pub def test003(): Bool = semVer(0, 0, 0) < semVer(0, 0, 1)

@Test
pub def test004(): Bool = semVer(0, 1, 0) > semVer(0, 0, 1)

@Test
pub def test005(): Bool = semVer(1, 0, 0) > semVer(0, 9, 9)

@Test
pub def test006(): Bool = semVer(3, 2, 1) > semVer(1, 2, 3)

@Test
pub def test007(): Bool = semVer(1, 0, 1) < semVer(1, 1, 0)

@Test
pub def test008(): Bool \ NonDet = {
    let r = Random.newWithSeed(83_123_002i64);
    let next = _ -> Random.nextNatWithMax(r, 1_000_000);
    List.range(0, 5000) |> List.forAll(_ -> {
        let x11 = next();
        let x12 = next();
        let x13 = next();
        let x21 = next();
        let x22 = next();
        let x23 = next();
        let semVerComp = semVer(x11, x12, x13) <=> semVer(x21, x22, x23);
        let tripleComp = (x11, x12, x13) <=> (x21, x22, x23);
        semVerComp == tripleComp
    })
}

}
