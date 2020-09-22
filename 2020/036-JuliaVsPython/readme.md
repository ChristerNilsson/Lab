JULIA vs Python vs Javascript

* saknar zero based arrays. Kan kringgås med OffsetArrays
* Dict() istf {}
* saknar dict.attr istf dict.["attr"].
* Specialtecken för xor (⊻) och heltalsdivision (÷).
* Saknar ++ och --
* Rubylik end-hantering istf indentering a la Python.
* Klasser saknas. Funktioner istf metoder. Dispatch på typ.

```
          slow    Quick
julia    2.1 s    32 ms
python 329 s     967 ms
coffee   3.5 s    28 ms
```