The GAP 4 package `UnitalSZ`
============================

**Algorithms and library of abstract unitals and their embeddings**

* Website: https://nagygp.github.io/UnitalSZ/
* Repository: https://github.com/nagygp/UnitalSZ


Install
-------

You can download the `tar` of the package from the homepage [GAP Package
UnitalSZ](https://nagygp.github.io/UnitalSZ/) and you can install it for
**GAP** the usual way. Check the homepage for the dependencies of the package
`UnitalSZ`.

Example session in GAP
----------------------

In the following example we define `her` to be the Hermitian unital of order 8
and `bm_unital` to be *the*  orthogonal Buekenhout--Metz (BM) unital of order 8
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

As we have seen, there is some information stored about the unital objects
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

On unitals
----------

The concept of *unitals* arises from *unitary* polarities over finite
projective planes: the absolute points of such a polarity form a unital. The
combinatorial properties of a unital obtained as above lead us to the
definition of an abstract unital.

In design theory context we call a 2-(q³+1, q+1, 1) design an **abstract
unital**.  It means that we have q³+1 *points* and subsets with q+1 elements of
the points called *blocks* and for every *pair of points* there is *exactly one
block* containing these 2 points.

Currently there are **4 "named" unitals** available in the package:

-   the **Hermitian** unital: `HermitianAbstractUnital( q )`;
-   the **orthogonal Buekenhout--Metz** unital:
    `OrthogonalBuekenhoutMetzAbstractUnital( q, alpha, beta )`;
-   the **Buekenhout--Tits** unital: `BuekenhoutTitsAbstractUnital( q )` and
-   the cyclic unital due to **Bagchi and Bagchi**: `BagchiBagchiCyclicUnital(
    n )`.

Of course there are options for **constructing** your own **unital**:

-   by the list of its blocks: `AbstractUnitalByDesignBlocks( blocklist )`;
-   by its incidence matrix (blocks &times; points):
    `AbstractUnitalByIncidenceMatrix( incmat )`;
-   by a boolean matrix based on its incidence matrix:
    `AbstractUnitalByBlistList( bmat )`.

There is also access to different attributes of a unital:

-   **points**: `PointsOfUnital( u )`;
-   names of the points: `PointNamesOfUnital( u )`. If there is any. It comes
    handy when the (abstract) unital can be represented in a more structured
    way (e.g., Buekenhout--Metz unital).
-   **Blocks**: `BlocksOfUnital( u )`;
-   incidence (di)graph: `IncidenceDigraph( u )`;
-   **automorphism group**: `AutomorphismGroup( u )`.

And as in the example above, one can check **isomorphism** between two unitals
`u1` and `u2` with `Isomorphism( u1, u2 )`.

Available libraries of unitals
------------------------------

Apart from the unitals mentioned above, we've made **3 libraries of unitals
available** : they are results of different papers (see the section
*References* in the documentation for more details).  A useful command can be
the following, which prints some essential informations about these libraries:

```
gap> AbstractUnitalLibraryInfo();
```

Full points and perspectivity groups
------------------------------------

For the definition of a **full point** see the documentation. They can be seen
as tools for obtaining non-embeddability results. The following command
computes the full points of the first unital in the KNP library (up to
automorphisms of the unital):

```
gap> FullPointsOfUnitalRepresentatives( KNPAbstractUnital(1) );
[ rec( block1 := [ 1, 2, 3, 4, 5 ], block2 := [ 6, 10, 27, 35, 41 ], fullpts :=
[ 39 ] ), rec( block1 := [ 1, 2, 3, 4, 5 ], block2 := [ 6, 36, 52, 58, 63 ],
fullpts := [ 9, 34, 50, 59, 64 ] ) ]
```

The **group of perspectivities** from one block to another is closely related
to full points, and it serves as tool for testing embeddability.
`PerspectivityGroupOfUnitalsBlocks` is the  command for computing this group.
For the exact specification of its arguments please refer to the documentation.

Acknowledgement
---------------

- Support provided from the National Research, Development and Innovation Fund of Hungary, financed under the 2018-1.2.1-NKP funding scheme, within the SETIT Project (2018-1.2.1-NKP-2018-00004).
- Partially supported by NKFIH-OTKA Grants 114614, 119687 and 115288.
- D. Mezőfi has been supported by the UNKP-17-3 New National Excellence Program of the Ministry of Human Capacities.