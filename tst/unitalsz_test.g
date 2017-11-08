LoadPackage("unitalsz");

her:=AU_HermitianAbstractUnital(4);
KnownAttributesOfObject(her);

knps:=List([1..AU_NrKNPUnitals],i->AU_KNPUnital(i));; time;
knps[4];
List(knps,AutomorphismGroup);; time;
Collected(List(knps,x->Size(AutomorphismGroup(x)))); time;

AU_Isomorphism(her,knps[1]);
AU_Isomorphism(her,knps[2]);

#p:=Random(SymmetricGroup(q^3+1));
#AU_Isomorphism(u,u^p);
#u^last=u^p;
