mod SemVer.Parser {
    use String.indexOfLeft
    use String.isMatch
    use String.splitAt
    use String.dropLeft
    use FromString.fromString

    pub def fromString(v: String): Option[SemVer] = {
        for (
            (major, rest1) <- consumeMajor(v);
            (minor, rest2) <- consumeMinor(rest1);
            (patch, rest3) <- consumePatch(rest2);
            _ <- if (rest3 == "") Some() else None
        ) yield SemVer(major, minor, patch)
    }

    ///
    /// Split the string `s` into `(a, b)` where `a` is the prefix of `s` up to
    /// the first occurance of `stop` (not including `stop`) and `b` is the
    /// string following that (also not including `stop`).
    ///
    /// `splitOnFirstLeft(stop = ".", "aaa.bbb.ccc") = Some(("aaa", "bbb.ccc"))`
    ///
    def splitOnFirstLeft(stop: {stop = String}, s: String): Option[(String, String)] = {
        use String.{dropLeft, splitAt};
        for (
            i <- indexOfLeft(substr = stop.stop, s)
        ) yield {
            let (left, right) = splitAt(i, s);
            (left, dropLeft(String.length(stop.stop), right))
        }
    }

    /// Converts a non-paded non-signed integer string to an integer.
    def parseVersionNumber(s: String): Option[Int32] = {
        let pos = isMatch(regex = "[1-9][0-9]*", s);
        let zero = s == "0";
        if (zero or pos) fromString(s)
        else None
    }

    /// Tries to consume the major version prefix of the string.
    def consumeMajor(s: String): Option[(Int32, String)] = {
        for (
            (majorStr, majorSuffix) <- splitOnFirstLeft(stop = ".", s);
            major <- parseVersionNumber(majorStr)
        ) yield (major, majorSuffix)
    }

    /// Tries to consume the minor version prefix of the string.
    def consumeMinor(s: String): Option[(Int32, String)] = {
        consumeMajor(s)
    }

    def consumePatch(s: String): Option[(Int32, String)] = {
        // stop at '-' if it is found
        let preIndex = indexOfLeft(substr = "-", s);
        // otherwise stop at '+' if it is found
        let metaIndex = match preIndex {
            case Some(v) => Some(v)
            case None => indexOfLeft(substr = "+", s)
        };
        // otherwise take the whole string
        let (patchStr, patchSuffix) = match metaIndex {
            case Some(v) =>
                let (l, r) = splitAt(v, s);
                (l, dropLeft(1, r))
            case None => (s, "")
        };
        for (
            patch <- parseVersionNumber(patchStr)
        ) yield (patch, patchSuffix)
    }
}
