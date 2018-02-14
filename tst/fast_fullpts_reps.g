LoadPackage("unitalsz");

fullpts_reps_1:=function( u )
    local bmattr, pts, nobls, bls, lsfullpoints, ij, blocki, blockj,
          nonincpts, fullpoints, p, bp, ibls, coveredpts,
        g,orbs;
    bmattr := TransposedMat( u!.bmat );
    pts := [ 1..Order( u )^3 + 1 ];
    nobls := Order( u )^2 * ( Order( u )^2 - Order( u ) + 1 );
    bls := [ 1..nobls ];
    lsfullpoints := [];
    # we compute the block pairs up to automorphisms
    g:=Action(AutomorphismGroup(u),BlocksOfUnital(u),OnSets);
    orbs:=List(List(Orbits(g,[1..nobls]),Minimum),i->List(Orbits(Stabilizer(g,i),[1..nobls]),o->[i,Minimum(o)]));
    orbs:=Filtered(List(Concatenation(orbs),Set),x->Length(x)=2);
    # main part
    for ij in orbs do
        blocki := u!.bmat[ ij[1] ];
        blockj := u!.bmat[ ij[2] ];
        nonincpts := ListBlist( pts, List( UnionBlist( blocki, blockj ),
                                            x -> not x ) );
        fullpoints := [];
        for p in nonincpts do
            bp := ListBlist( bls, bmattr[ p ] );
            ibls := Filtered( bp, x -> SizeBlist( IntersectionBlist(
                    u!.bmat[ x ], blocki ) ) > 0 );
            coveredpts := Flat( List( ibls, x -> ListBlist( pts,
                            IntersectionBlist( u!.bmat[ x ], blockj ) ) ) );
            if ListBlist( pts, blockj ) = Set( coveredpts ) then
                Add( fullpoints, p );
            fi;
        od;
        if Length( fullpoints ) <> 0 then
            Add( lsfullpoints, rec( block1 := ij[1], block2 := ij[2],
                                    fullpts := fullpoints ) );
        fi;
    od;
    return lsfullpoints;
end;

index_of_span:=function(u,p1,p2) 
    local i1,i2;
    i1:=PositionSorted(PointsOfUnital(u),p1); 
    i2:=PositionSorted(PointsOfUnital(u),p2);      
    return First([1..Order(u)^4-Order(u)^3+Order(u)^2],i->u!.bmat[i][i1] and u!.bmat[i][i2]);                                                                   
end;

meet_by_index_1:=function(u,bi1,bi2)
    local ret;
    ret:=ListBlist([1..Order(u)^3+1],IntersectionBlist(u!.bmat[bi1],u!.bmat[bi2]));
    if ret=[] then 
        return [];
    else
        return ret[1];
    fi;
end;

meet_by_index_2:=function(u,bi1,bi2)
    local ret;
    ret:=Intersection(BlocksOfUnital(u)[bi1],BlocksOfUnital(u)[bi2]);
    if ret=[] then 
        return [];
    else
        return ret[1];
    fi;
end;

###

u:=HermitianAbstractUnital(8);

for i in [1..10000] do a:=index_of_span(u,Random(PointsOfUnital(u)),Random(PointsOfUnital(u))); od; time;

for i in [1..10000] do a:=meet_by_index_1(u,Random([1..Order(u)^4-Order(u)^3+Order(u)^2]),Random([1..Order(u)^4-Order(u)^3+Order(u)^2])); od; time;

for i in [1..10000] do a:=meet_by_index_2(u,Random([1..Order(u)^4-Order(u)^3+Order(u)^2]),Random([1..Order(u)^4-Order(u)^3+Order(u)^2])); od; time;

fullpts_reps_2:=function(u)
    local nobls,g,orbs,lsfullpoints,i,b,fullpts,p,r,non_p_pts;
    nobls := Order( u )^2 * ( Order( u )^2 - Order( u ) + 1 );
    g:=Action(AutomorphismGroup(u),BlocksOfUnital(u),OnSets);
    orbs:=List(List(Orbits(g,[1..nobls]),Minimum),i->List(Orbits(Stabilizer(g,i),[1..nobls]),o->[i,Minimum(o)]));
    orbs:=Filtered(orbs[1],x->x[1]<x[2]);
    lsfullpoints := [];
    for i in orbs do
        b:=BlocksOfUnital(u){i};
        fullpts:=[];
        non_p_pts:=Difference(PointsOfUnital(u),Union(b));
        for p in non_p_pts do
            r:=List(b[1],x->meet_by_index_1(u,index_of_span(u,x,p),i[2]));
            if not [] in r then
                Add(fullpts,p);
            fi;
        od;
        if fullpts<>[] then
            Add( lsfullpoints, rec( block1 := i[1], block2 := i[2], fullpts := fullpts ) );
        fi;
    od;
    return lsfullpoints;
end;

u:=HermitianAbstractUnital(8);
fullpts_reps_1(u); time;

u:=HermitianAbstractUnital(8);
fullpts_reps_2(u); time;

