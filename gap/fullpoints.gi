###############################################################################
##  FULL POINTS
##  ---------------------------------------------------------------------------

InstallMethod( FullPointsOfUnitalRepresentatives, "for an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
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
            Add( lsfullpoints, rec( block1 := BlocksOfUnital( u )[ij[1]], block2 := BlocksOfUnital( u )[ij[2]],
                                    fullpts := fullpoints ) );
        fi;
    od;
    return lsfullpoints;
end );

InstallMethod( FullPointsOfUnital, "for an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    return fail;
end );

InstallMethod( GeneratorsOfProjectivityGroupsOfUnital, "for an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    local bmattr, pts, bls, lsfullpoints, lsfullpointsgens, i, p, ibls,
          ib1, ib2, imblock1, fullpointsgens, permblock1;
    bmattr := TransposedMat( u!.bmat );
    pts := [ 1..Order( u )^3 + 1 ];
    bls := [ 1..Order( u )^2 * ( Order( u )^2 - Order( u ) + 1 ) ];
    lsfullpoints := FullPointsOfUnitalRepresentatives( u );
    lsfullpointsgens := [];
    for i in lsfullpoints do
        p := i.fullpts[ 1 ];
        ib1 := Position( BlocksOfUnital( u ), i.block1 );
        ib2 := Position( BlocksOfUnital( u ), i.block2 );
        ibls := Flat( List( ListBlist( pts, u!.bmat[ ib1 ] ),
                            x -> ListBlist( bls, IntersectionBlist(
                                 bmattr[ p ], bmattr[ x ] ) ) ) );
        imblock1 := Flat( List( ibls,
                                x -> ListBlist( pts, IntersectionBlist(
                                     u!.bmat[ x ], u!.bmat[ ib2 ] ) ) ) );
        fullpointsgens := [];
        for p in i.fullpts do
            ibls := Flat( List( imblock1, x -> ListBlist( bls,
                                               IntersectionBlist( bmattr[ p ],
                                               bmattr[ x ] ) ) ) );
            permblock1 := Flat( List( ibls,
                                      x -> ListBlist( pts, IntersectionBlist(
                                      u!.bmat[ x ], u!.bmat[ ib1 ] ) ) ) );
            Add( fullpointsgens, Sortex( permblock1 ) );
        od;
        Add( lsfullpointsgens, rec( block1 := i.block1,
                                    block2 := i.block2,
                                    fullpts := i.fullpts,
                                    projgens := fullpointsgens ) );
    od;
    return lsfullpointsgens;
end );
