/// Represents a semantic version.
opaque enum SemVer(
    Int32,  // major: major version
    Int32,  // minor: minor version
    Int32   // patch: patch version
) with Eq, Order

mod SemVer {

    /// Returns version `0.1.0`.
    pub def firstVersion(): SemVer = SemVer(0, 1, 0)

    ///
    /// Returns the semantic version of given by `major`, `minor`, and
    /// `patch` as given by their natural order.
    ///
    /// Returns `None` if any arguments are negative.
    ///
    pub def semVer(major: Int32, minor: Int32, patch: Int32): Option[SemVer] = {
        if (major >= 0 and minor >= 0 and patch >= 0)
            Some(SemVer(major, minor, patch))
        else
            None
    }

    ///
    /// Returns the semantic version of given by `major`, `minor`, and
    /// `patch` as given by their natural order.
    ///
    /// Arguments are replaced by `0` if negative.
    ///
    pub def semVerLenient(major: Int32, minor: Int32, patch: Int32): SemVer = {
        let bound = Int32.max(0);
        SemVer(bound(major), bound(minor), bound(patch))
    }

    /// Returns the major (first) part of the version.
    pub def getMajor(v: SemVer): Int32 = {
        let SemVer(major, _, _) = v;
        major
    }

    /// Returns the minor (second) part of the version.
    pub def getMinor(v: SemVer): Int32 = {
        let SemVer(_, minor, _) = v;
        minor
    }

    /// Returns the patch (third) part of the version.
    pub def getPatch(v: SemVer): Int32 = {
        let SemVer(_, _, patch) = v;
        patch
    }

    ///
    /// Increases the major part of the version,
    /// thus resetting all other parts.
    ///
    pub def increaseMajor(v: SemVer): SemVer = {
        SemVer(getMajor(v) + 1, 0, 0)
    }

    ///
    /// Increases the minor part of the version,
    /// thus resetting the patch part.
    ///
    pub def increaseMinor(v: SemVer): SemVer = {
        SemVer(getMajor(v), getMinor(v) + 1, 0)
    }

    /// Increases the patch part of the version.
    pub def increasePatch(v: SemVer): SemVer = {
        SemVer(getMajor(v), getMinor(v), getPatch(v) + 1)
    }

    /// Parses the input string as a semantic version.
    pub def fromString(s: String): Option[SemVer] = {
        SemVer.Parser.fromString(s)
    }

    /// Returns the string representation of the semantic version.
    pub def toString(v: SemVer): String = {
        let SemVer(major, minor, patch) = v;
        "${major}.${minor}.${patch}"
    }

}

instance ToString[SemVer] {
    pub def toString(v: SemVer): String = SemVer.toString(v)
}

instance FromString[SemVer] {
    pub def fromString(v: String): Option[SemVer] = SemVer.fromString(v)
}
