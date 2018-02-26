#########################################################
###   Tests for of the Bagchi-Bagchi cyclic unitals   ###
#########################################################

LoadPackage("UnitalSZ");

# parameters:
# n | 2 | 3 |  4 |  6 |  7 |  8 | 10 |  12 |  15 |  16 |  18 | 
# p | 3 | 4 |  5 |  7 |  8 |  9 | 11 |  13 |  16 |  17 |  19 | 
# q | 3 | 7 | 13 | 31 | 43 | 57 | 91 | 133 | 211 | 247 | 307 | 
# U | 0 | 0 |  1 |  1 |  0 | -- | -- |  -- |   0 |   0 |   0 | 

BagchiBagchiCyclicUnital(3);
BagchiBagchiCyclicUnital(4);
BagchiBagchiCyclicUnital(6);
BagchiBagchiCyclicUnital(7);

u4:=BagchiBagchiCyclicUnital(4);
u6:=BagchiBagchiCyclicUnital(6);
a:=AutomorphismGroup(u6);
Size(a);
StructureDescription(a);

b1:=Random(BlocksOfUnital(u6));
b2:=Random(BlocksOfUnital(u6));
PerspectivityGroupOfUnitalsBlocks(u6,b1,b2);
FullPointsOfUnitalRepresentatives(u6);

OrbitLengths(AutomorphismGroup(u6),BlocksOfUnital(u6),OnSets);
