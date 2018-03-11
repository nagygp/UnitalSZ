###################################
# Test("/tmp/unitalsz_test.tst");
###################################
# gap -A -x 80 -r -m 100m -o 1g 
# SetPackagePath( "UnitalSZ", "/home/gap/.gap/pkg/UnitalSZ" );
# GAPInfo.RootPaths;
# TestPackage("unitalsz");
# 
# gap -A -x 80 -r -m 100m -o 1g 
# SetPackagePath( "UnitalSZ", "/home/gap/.gap/pkg/UnitalSZ" );
# GAPInfo.RootPaths;
# LoadAllPackages();
# TestPackage("unitalsz");
###################################
###################################
LogTo("/tmp/unitalsz_test.tst");
START_TEST("UnitalSZ package: unitalsz_test.tst");
SizeScreen([72,23]);

LoadPackage("unitalsz", false);

###################################

her := HermitianAbstractUnital( 4 );
KnownAttributesOfObject( her );

knps := List( [ 1..AU_NrKNPUnitals ], i -> KNPAbstractUnital( i ) );;
knps[ 4 ];
List( knps, AutomorphismGroup );;
Collected( List( knps, x -> Size( AutomorphismGroup( x ) ) ) );

Isomorphism( her, knps[ 1 ] );
Isomorphism( her, knps[ 2 ] );

u:=knps[9];
fp:=FullPointsOfUnitalRepresentatives(u);;
List(fp,r->Size(r.fullpts));

for r in fp do
    if Length(r.fullpts)>1 then
        g:=PerspectivityGroupOfUnitalsBlocks(u,r.block1,r.block2,r.fullpts);
        Print("# ",Size(Intersection(r.block1,r.block2))," ",StructureDescription(g)," ", NrMovedPoints(g), "\n");
    fi;
od;

###################################

BagchiBagchiCyclicUnital(3);
BagchiBagchiCyclicUnital(7);
u4:=BagchiBagchiCyclicUnital(4);
u6:=BagchiBagchiCyclicUnital(6);

a:=AutomorphismGroup(u6);
Size(a);
StructureDescription(a);
OrbitLengths(AutomorphismGroup(u6),BlocksOfUnital(u6),OnSets);

FullPointsOfUnitalRepresentatives(u6);

###################################

q := 2^3;
params := AllBuekenhoutMetzAbstractUnitalParameters(q);;
Length(params);

bm_unital :=  OrthogonalBuekenhoutMetzAbstractUnital(q,params[1][1],params[1][2]);
ag := AutomorphismGroup(bm_unital);
OrbitLengths(ag);

bt_unital := BuekenhoutTitsAbstractUnital(q);

ag := AutomorphismGroup(bt_unital);
OrbitLengths(ag);

###################################

STOP_TEST( "testall.tst", 10000 );
LogTo();

StringTime(Runtime());
