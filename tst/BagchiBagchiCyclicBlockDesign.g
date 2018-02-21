############################################################
###   Construction of the Bagchi-Bagchi cyclic unitals   ###
############################################################

LoadPackage("UnitalSZ");

DeclareGlobalFunction("BagchiBagchiCyclicUnital");

# parameters:
# n | 2 | 3 |  4 |  6 |  7 |  8 | 10 |  12 |  15 |  16 |  18 | 
# p | 3 | 4 |  5 |  7 |  8 |  9 | 11 |  13 |  16 |  17 |  19 | 
# q | 3 | 7 | 13 | 31 | 43 | 57 | 91 | 133 | 211 | 247 | 307 | 
# U | 0 | 0 |  1 |  1 |  0 | -- | -- |  -- |   0 |   0 |   0 | 
InstallGlobalFunction( BagchiBagchiCyclicUnital, 
function(n)
    local p,q,gq,gp,t,gamma,pts,us,u,f,A0,Ainf,perm,B,j,BB;

    # Parameter check
    p:=n+1;
    q:=n^2-n+1;
    if not(IsPrimePowerInt(p) and IsPrimePowerInt(q)) then 
        Error("wrong argument");
    fi;
    # For parameters n<=20, the only known cyclic unitals are for n=4 and n=6, and they are unique.
    # In order to force computation for an arbitrary n, comment out the next lines:
    if n in [2,3,7,15,16,18] then return fail; fi;
    if n > 20 then Error("computationally hopeless for orders > 20"); fi;
    # Preparation
    gq:=Z(q)^((q-1)/(p-1));
    gp:=Z(p)^2;
    t:=First(Reversed(DivisorsInt(p-1)),x->Gcd(x,(q-1)/(p-1))=1);
    gamma:=Z(q)^t;
    pts:=Cartesian(GF(p),GF(q));
    us:=Filtered(Group(gp),u->Order(u)=Order(gp));
    # Trying out admissible u's
    for u in us do
        f:=function(x) if IsZero(x) then return 0*gp; else return u^LogFFE(x,gq); fi; end;
        A0:=Set(Union([0*gq],Elements(Group(gq))),x->[f(x),x]);
        Ainf:=Set(GF(p),x->Position(pts,[x,0*gq]));
        perm:=PermList(List(pts,y->Position(pts,y+[1,1])));
        B:=[Ainf];
        for j in [0..(q-1)/(p-1)-1] do 
            Add(B,Set(A0,x->Position(pts,[x[1],gamma^j*x[2]]))); 
        od;
        BB:=Union(List(B,x->Orbit(Group(perm),x,OnSets)));
        # Check for the unital property
        if Length(BB)=(p-1)^2*q and AU_IsUnitalBlockDesign(BB) then
            BB:=AbstractUnitalByDesignBlocks(BB);
            SetName(BB,Concatenation("BagchiBagchiCyclicUnital(",String(n),")"));
            SetPointNamesOfUnital(BB,pts); # sense???
            return BB;
        fi;
    od;
    return fail;
end);

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
