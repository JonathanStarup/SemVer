# SemVar

A Flix package for [Semantic Versioning 2.0](https://semver.org/).

# Example Use

```scala

//
// A SemVer can be created
//
SemVer.firstVersion(); // 0.1.0
SemVer.semVer(1, 2, 3); // Some(1.2.3)
SemVer.semVer(1, 2, -1); // None
SemVer.semVerLenient(1, 2, -1); // 1.2.0
SemVer.fromString("1.2.3"); // 1.2.3
FromString.fromString("99.99.98"); // Some(99.99.98)
FromString.fromString("099.99.98"); // None
FromString.fromString("99.99.98-alpha"); // None
FromString.fromString("99.99.98-alpha+meta"); // None

//
// Information can be extracted from a SemVer
//
let v = SemVer.semVer(1, 2, 3);
SemVer.getMajor(v); // 1
SemVer.getMinor(v); // 2
SemVer.getPatch(v); // 3
SemVer.toString(v); // "1.2.3"
ToString.toString(v); // "1.2.3"

//
// A SemVer can be modified
//
let v = SemVer.semVer(1, 2, 3);
SemVer.increaseMajor(v); // 2.0.0
SemVer.increaseBreaking(v); // 2.0.0
SemVer.increaseMinor(v); // 1.3.0
SemVer.increasePatch(v); // 1.2.4
SemVer.increaseBugFix(v); // 1.2.4

//
// A SemVer can be compared
//
let v1 = SemVer.semVer(1, 2, 3);
let v2 = SemVer.semVer(1, 3, 1);
v1 == v2; // false
v1 > v2 // false
v1 < v2 // true
v1 <=> v2 // LessThan

```

# License

See full license [here](LICENSE.md)

Copyright 2023 Jonathan Lindegaard Starup

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
