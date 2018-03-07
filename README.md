The GAP 4 package `UnitalSZ`
============================

**Algorithms and library of abstract unitals and their embeddings**

See the package documentation on
[`https://nagygp.github.io/UnitalSZ/`](https://nagygp.github.io/UnitalSZ/).

>   Supported by the UNKP-17-3 New National Excellence Program of the Ministry
>   of Human Capacities, and by NKFIH-OTKA Grants 114614 and 119687.

Install
-------

You can download the `tar` of the package from the homepage [GAP Package
UnitalSZ](https://nagygp.github.io/UnitalSZ/) and install it for **GAP** the
usual way. Check the homepage for the dependencies of `UnitalSZ`.

Example session in GAP
----------------------

In the following example we define `her` to be the Hermitian unital of order 8
and `bm_unital` to be *the*  orthogonal Buekenhout-Metz (BM) unital of order 8
as well. Note the "the": for other `q`s there may be more non-isomorphic
BM-unitals.

```
gap> LoadPackage( "UnitalSZ" );
gap> q := 2^3;;
gap> her := HermitianAbstractUnital( q );;
gap> KnownAttributesOfObject( her );
[ "Name", "Order" ]
gap> params := AllBuekenhoutMetzAbstractUnitalParameters( q );;
gap> Length( params );
1 
gap> bm_unital := OrthogonalBuekenhoutMetzAbstractUnital( q, params[1][1], params[1][2] );
OrthogonalBuekenhoutMetzAbstractUnital(8,Z(2^6)^62,Z(2^6)^60)
gap> KnownAttributesOfObject( bm_unital );
[ "Name", "Order", "PointNamesOfUnital" ]
```

Then we compute the automorphism group of `bm_unital` and the orbit
lengths of this group. We also check whether the Hermitian unital `her` and the
BM-unital `bm_unital` are isomorphic or not: the result `fail` indicates that
they are not isomorphic (of course).

```
gap> ag := AutomorphismGroup( bm_unital );;
gap> OrbitLengths( ag );
[ 512 ]
gap> Isomorphism( her, bm_unital );
fail
```

As we have seen, there are some information stored about the unital objects
`her` and `bm_unital`: we can access these with the command
`KnownAttributesOfObject`. After computing the *full points* of
`bm_unital` we obtain much more information about the unital. With
`SetInfoLevel` we get some additional messages about the ongoing computation
of the full points. 

```
gap> SetInfoLevel( InfoUnitalSZ, 2);
gap> FullPointsOfUnitalRepresentatives( bm_unital );;
#I  1896 block pair(s) up to automorphisms computed
#I  1 full point(s) found
#I  2 full point(s) found
#I  3 full point(s) found
#I  4 full point(s) found
#I  5 full point(s) found
#I  6 full point(s) found
#I  7 full point(s) found
gap> KnownAttributesOfObject( bm_unital );
[ "Name", "Order", "AutomorphismGroup", "PointsOfUnital", "BlocksOfUnital",
"PointNamesOfUnital", "IncidenceDigraph", "FullPointsOfUnitalRepresentatives" ]
```
