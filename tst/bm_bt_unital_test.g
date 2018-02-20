LoadPackage("unitalsz");

her := HermitianAbstractUnital( 4 );
KnownAttributesOfObject( her );

###################################

q := 2^3;
params := AllBuekenhoutMetzAbstractUnitalParameters(q);;
Length(params);

bm_unital :=  OrthogonalBuekenhoutMetzAbstractUnital(q,params[1][1],params[1][2]);
ag := AutomorphismGroup(bm_unital);
OrbitLengths(ag);
FullPointsOfUnitalRepresentatives(bm_unital);
time;

###################################

ab:=Random(params);
bm_unital2 :=  OrthogonalBuekenhoutMetzAbstractUnital(q,ab[1],ab[2]);
ag2 := AutomorphismGroup(bm_unital2);
OrbitLengths(ag2);
FullPointsOfUnitalRepresentatives(bm_unital2);

###################################

bt_unital := BuekenhoutTitsAbstractUnital(q);

ag := AutomorphismGroup(bt_unital);
OrbitLengths(ag);

###################################

StringTime(Runtime());

