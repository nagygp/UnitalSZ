gap> START_TEST("UnitalSZ package: unitalsz_test.tst");
gap> SizeScreen([72,23]);
[ 72, 23 ]
gap> 
gap> LoadPackage("unitalsz", false);
true
gap> 
gap> ###################################
gap> 
gap> her := HermitianAbstractUnital( 4 );
HermitianAbstractUnital(4)
gap> KnownAttributesOfObject( her );
[ "Name", "Order" ]
gap> 
gap> knps := List( [ 1..AU_NrKNPUnitals ], i -> KNPAbstractUnital( i ) );;
gap> knps[ 4 ];
KNPAbstractUnital(4)
gap> List( knps, AutomorphismGroup );;
gap> Collected( List( knps, x -> Size( AutomorphismGroup( x ) ) ) );
[ [ 4, 4 ], [ 8, 12 ], [ 12, 2 ], [ 13, 62 ], [ 16, 12 ], [ 20, 2 ], 
  [ 24, 8 ], [ 32, 57 ], [ 39, 1277 ], [ 48, 7 ], [ 50, 24 ], 
  [ 64, 67 ], [ 78, 4 ], [ 80, 2 ], [ 96, 5 ], [ 100, 89 ], 
  [ 128, 82 ], [ 150, 2 ], [ 156, 1 ], [ 192, 8 ], [ 200, 17 ], 
  [ 256, 12 ], [ 260, 1 ], [ 300, 10 ], [ 384, 1 ], [ 600, 3 ], 
  [ 768, 3 ], [ 780, 1 ], [ 1200, 1 ], [ 249600, 1 ] ]
gap> 
gap> Isomorphism( her, knps[ 1 ] );
(2,5,34,40,33,37,29,17,47,54,10,59,64,4,39,50,55)(3,9,60,23,28,19,13,
49,46,6,11,31,58,30,52,53,32,8,56,24,35,63,7,38,57,48,36,21,27,44,45,
41,18,61,62,20,43,42,65)(14,16)(25,26,51)
gap> Isomorphism( her, knps[ 2 ] );
fail
gap> 
gap> u:=knps[9];
KNPAbstractUnital(9)
gap> fp:=FullPointsOfUnitalRepresentatives(u);;
gap> List(fp,r->Size(r.fullpts));
[ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 5, 1, 1, 1, 1, 1, 1, 
  1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 2, 1, 
  1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 3, 1, 2, 1, 1, 1, 1, 1, 1, 2, 
  1, 1, 1, 1, 5, 1, 5, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 5, 5, 1, 5, 
  5, 1, 1, 1, 5, 5, 1, 1, 1, 1, 1, 2, 1, 1, 5, 1, 5, 1, 1, 5, 1, 5 ]
gap> 
gap> for r in fp do
>     if Length(r.fullpts)>1 then
>         g:=PerspectivityGroupOfUnitalsBlocks(u,r.block1,r.block2,r.fullpts);
>         Print("# ",Size(Intersection(r.block1,r.block2))," ",StructureDescription(g)," ", NrMovedPoints(g), "\n");
>     fi;
> od;
# 0 C2 4
# 0 C5 5
# 0 C5 5
# 0 S5 5
# 0 C5 5
# 0 C5 5
# 0 S5 5
# 0 C5 5
# 0 C5 5
# 0 C5 5
# 0 C5 5
# 0 C5 5
# 0 C5 5
# 0 C5 5
# 0 C5 5
# 0 C5 5
# 0 C5 5
# 0 C5 5
# 0 C2 4
# 0 C5 5
# 0 C5 5
# 0 C5 5
# 0 C5 5
gap> 
gap> ###################################
gap> 
gap> BagchiBagchiCyclicUnital(3);
fail
gap> BagchiBagchiCyclicUnital(7);
fail
gap> u4:=BagchiBagchiCyclicUnital(4);
BagchiBagchiCyclicUnital(4)
gap> u6:=BagchiBagchiCyclicUnital(6);
BagchiBagchiCyclicUnital(6)
gap> 
gap> a:=AutomorphismGroup(u6);
<permutation group with 3 generators>
gap> Size(a);
6510
gap> StructureDescription(a);
"((C7 x (C31 : C5)) : C3) : C2"
gap> OrbitLengths(AutomorphismGroup(u6),BlocksOfUnital(u6),OnSets);
[ 1085, 31 ]
gap> 
gap> FullPointsOfUnitalRepresentatives(u6);
[  ]
gap> 
gap> ###################################
gap> 
gap> q := 2^3;
8
gap> params := AllBuekenhoutMetzAbstractUnitalParameters(q);;
gap> Length(params);
1
gap> 
gap> bm_unital :=  OrthogonalBuekenhoutMetzAbstractUnital(q,params[1][1],params[1][2]);
OrthogonalBuekenhoutMetzAbstractUnital(8,Z(2^6)^62,Z(2^6)^60)
gap> ag := AutomorphismGroup(bm_unital);
<permutation group with 5 generators>
gap> OrbitLengths(ag);
[ 512 ]
gap> 
gap> bt_unital := BuekenhoutTitsAbstractUnital(q);
BuekenhoutTitsAbstractUnital(8)
gap> 
gap> ag := AutomorphismGroup(bt_unital);
<permutation group with 7 generators>
gap> OrbitLengths(ag);
[ 384, 128 ]
gap> 
gap> ###################################
gap> 
gap> STOP_TEST( "testall.tst", 10000 );