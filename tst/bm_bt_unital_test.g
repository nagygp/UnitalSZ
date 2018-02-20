LoadPackage("unitalsz");

her := HermitianAbstractUnital( 4 );
KnownAttributesOfObject( her );

q := 2^3;
params := AllBuekenhoutMetzAbstractUnitalParameters(q);;
Length(params);

bm_unital :=  OrthogonalBuekenhoutMetzAbstractUnital(q,params[1][1],params[1][2]);
ag := AutomorphismGroup(bm_unital);
OrbitLengths(ag);
FullPointsOfUnitalRepresentatives(bm_unital);
time;

bt_unital := BuekenhoutTitsAbstractUnital(q);

ag := AutomorphismGroup(bt_unital);
OrbitLengths(ag);

StringTime(Runtime());

