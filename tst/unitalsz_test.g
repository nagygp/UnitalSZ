LoadPackage("unitalsz");

her := HermitianAbstractUnital( 4 );
KnownAttributesOfObject( her );

knps := List( [ 1..AU_NrKNPUnitals ], i -> KNPAbstractUnital( i ) );; time;
knps[ 4 ];
List( knps, AutomorphismGroup );; time;
Collected( List( knps, x -> Size( AutomorphismGroup( x ) ) ) ); time;

Isomorphism( her, knps[ 1 ] );
Isomorphism( her, knps[ 2 ] );

# p := Random( SymmetricGroup( q^3 + 1 ) );
# Isomorphism( u, u^p );
# u^last = u^p;

u:=knps[9];
fp:=FullPointsOfUnital(u);;time;
List(fp,r->Size(r.fullpts));

projection_perm:=function(u,b1,b2,p)
    local pbls,isect;
    pbls:=Filtered(BlocksOfUnital(u),b->p in b);
    isect:=List(b1,x->Intersection(b2,First(pbls,b->x in b)));
    if [] in isect then 
        return fail;
    fi;
    return PermList(List(isect,x->Position(b2,x[1])));
end;

GeneratorsOfProjectivityGroupsOfFullPoints:=function(u,r)
    local gens;
    gens:=List(r.fullpts,p->projection_perm(u,r.block1,r.block2,p));
    gens:=List([2..Length(gens)],i->gens[i]*gens[1]^-1);
    return gens;
end;

for r in fp do
    if Length(r.fullpts)>1 then
        gens:=GeneratorsOfProjectivityGroupsOfFullPoints(u,r);
        g:=Group(gens);
        Print("# ",Size(Intersection(r.block1,r.block2))," ",StructureDescription(g)," ", NrMovedPoints(g), "\n");
    fi;
od;

# there are disjoint blocks such that the generated group contains elements of order p=2.
# this implies that the unital cannot be embedded in PG(2,q^2), q=4.

bbts := List( [ 1..AU_NrBBTUnitals ], i -> BBTAbstractUnital( i ) );; time;

info:=[];
for i in [ 1..AU_NrBBTUnitals ] do 
    Print(i,"/",AU_NrBBTUnitals,"\r");
    u := BBTAbstractUnital( i );
    fp:=FullPointsOfUnital(u);
    for r in fp do
        if Length(r.fullpts)>1 then
            gens:=GeneratorsOfProjectivityGroupsOfFullPoints(u,r);
            g:=Group(gens);
            Add(info, [i,Size(Intersection(r.block1,r.block2)),StructureDescription(g), NrMovedPoints(g)]);
            #Print("# ",Size(Intersection(r.block1,r.block2))," ",StructureDescription(g)," ", NrMovedPoints(g), "\n");
        fi;
    od;
od;
Set(info,k->k{[2,3,4]});

# searching for unitals of order 3 such that for some full point with disjoint blocks, the group has order 3

non_embeddable:=[];
for k in info do
    if k[2]=0 and k[3]="C3" and k[4]=3 then 
        AddSet(non_embeddable,k[1]);
        Print( "# ",k[1],"\n");
    fi;
od;
non_embeddable;
Size(non_embeddable);

# this shows that 94 unitals of order 3 cannot be embedded