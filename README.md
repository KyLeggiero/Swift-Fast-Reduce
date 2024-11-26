# 📦 ARCHIVED
Hillariously, _immediately_ after making this, Swift #Sherlocked this by introducing [basically this exact function](https://github.com/swiftlang/swift/commit/e15ea5fcf31e769ceb9cea97a5376034299286c0). Beautiful!



# Swift Fast Reduce #

A much faster* version of the [Swift Standard Library's `reduce` function](https://github.com/apple/swift/blob/825e9d077d703bc2fb8f383a4a126f9fc2f40488/stdlib/public/core/SequenceAlgorithms.swift.gyb#L541-L599).

This function was created by Ky Leggiero and is licenced under [BH-0-PD](https://github.com/BlueHuskyStudios/Licenses/blob/master/Licenses/BH-0-PD.txt).

---

> *The speed of this algorithm was determined by converting very large data sets to a single object (These will be made public shortly). Other tests might show this to be the same speed or slower than Swift's standard version.
