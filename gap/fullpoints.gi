###############################################################################
##  FULL POINTS
##  ---------------------------------------------------------------------------

InstallMethod( FullPointsOfUnitalsBlocks, "for an abstract unital and indices of two blocks",
    [ IsAbstractUnitalDesign, IsPosInt, IsPosInt ],
function( u, ib1, ib2 )
    local bmattr, pts, nobls, bls, blocki, blockj, nonincpts, fullpoints, p, bp, ibls, coveredpts;
    nobls := Order( u )^2 * ( Order( u )^2 - Order( u ) + 1 );
    if ib1=ib2 or ib1>nobls or ib2>nobls then 
        Error("arguments 2 and 3 must be indices of two different blocks of the unital");
    fi;
    blocki := u!.bmat[ ib1 ];
    blockj := u!.bmat[ ib2 ];
    bmattr := TransposedMat( u!.bmat );
    pts := [ 1..Order( u )^3 + 1 ];
    bls := [ 1..nobls ];
    nonincpts := ListBlist( pts, List( UnionBlist( blocki, blockj ), x -> not x ) );
    fullpoints := [];
    for p in nonincpts do
        bp := ListBlist( bls, bmattr[ p ] );
        ibls := Filtered( bp, x -> SizeBlist( IntersectionBlist( u!.bmat[ x ], blocki ) ) > 0 );
        coveredpts := Flat( List( ibls, x -> 
            ListBlist( pts, IntersectionBlist( u!.bmat[ x ], blockj ) ) 
        ) );
        if ListBlist( pts, blockj ) = Set( coveredpts ) then
            Add( fullpoints, p );
        fi;
    od;
    return fullpoints;
end );

InstallOtherMethod( FullPointsOfUnitalsBlocks, "for an abstract unital and two blocks",
    [ IsAbstractUnitalDesign, IsList, IsList ],
function( u, b1, b2 )
    local bmattr, pts, nobls, bls, ib1, ib2, nonincpts, fullpoints, p, bp, ibls, coveredpts;
    ib1 := u!.bmat[ PositionSorted( BlocksOfUnital( u ), b1 ) ];
    ib2 := u!.bmat[ PositionSorted( BlocksOfUnital( u ), b2 ) ];
    if b1=b2 or b1 <> BlocksOfUnital( u )[ib1] or b2 <> BlocksOfUnital( u )[ib2] then 
        Error("arguments 2 and 3 must be different blocks of the unital");
    fi;
    return FullPointsOfUnitalsBlocks( u, ib1, ib2 );
end );

InstallMethod( FullPointsOfUnitalRepresentatives, "for an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    local nobls, lsfullpoints, ij, fullpoints, g, orbs;
    # we compute the block pairs up to automorphisms
    nobls := Order( u )^2 * ( Order( u )^2 - Order( u ) + 1 );
    g := Action( AutomorphismGroup( u ), BlocksOfUnital( u ), OnSets );
    orbs := List( List( Orbits( g, [ 1..nobls ] ), Minimum ), i -> 
        List( Orbits( Stabilizer( g, i ), [ 1..nobls ] ), o -> [ i, Minimum( o ) ] ) 
    );
    orbs := Filtered( List( Concatenation( orbs ), Set ), x -> Length( x ) = 2 );
    # main part
    lsfullpoints := [];
    for ij in orbs do
        fullpoints := FullPointsOfUnitalsBlocks( u, ij[1], ij[2] );
        if Length( fullpoints ) <> 0 then
            Add( lsfullpoints, rec( 
                block1 := BlocksOfUnital( u )[ ij[1] ], 
                block2 := BlocksOfUnital( u )[ ij[2] ], 
                fullpts := fullpoints 
            ) );
        fi;
    od;
    return lsfullpoints;
end );

InstallMethod( PerspectivityGroupOfUnitalsBlocks, "for an abstract unital, two blocks and a list of full points",
    [ IsAbstractUnitalDesign, IsList, IsList, IsList ],
function( u, b1, b2, fullpts )
    local bmattr, pts, bls, p, ibls, ib1, ib2, imblock1, fullpointsgens, permblock1;
    ib1 := PositionSorted( BlocksOfUnital( u ), b1 );
    ib2 := PositionSorted( BlocksOfUnital( u ), b2 );
    if b1=b2 or b1 <> BlocksOfUnital( u )[ib1] or b2 <> BlocksOfUnital( u )[ib2] then 
        Error("arguments 2 and 3 must be different blocks of the unital");
    fi;
    # We don't check if fullpts is a list of full points w.r.t. the blocks b1, b2
    bmattr := TransposedMat( u!.bmat );
    pts := [ 1..Order( u )^3 + 1 ];
    bls := [ 1..Order( u )^2 * ( Order( u )^2 - Order( u ) + 1 ) ];
    if Length( fullpts ) < 2 then
        return Group(());
    fi;
    # first full point p
    p := fullpts[ 1 ];
    # indices of blocks connecting p and points of b1
    ibls := Flat( List( b1, x -> 
        ListBlist( bls, IntersectionBlist( bmattr[ p ], bmattr[ x ] ) ) 
    ) );
    # points of b2, cut out by blocks of ibls
    imblock1 := Flat( List( ibls, x -> 
        ListBlist( pts, IntersectionBlist( u!.bmat[ x ], u!.bmat[ ib2 ] ) ) 
    ) );
    fullpointsgens := [];
    # generic full point p
    for p in fullpts do 
        # indices of blocks connecting p and points of b2
        ibls := Flat( List( imblock1, x -> 
            ListBlist( bls, IntersectionBlist( bmattr[ p ], bmattr[ x ] ) ) 
        ) );
        # points of b1, cut out by blocks of ibls
        permblock1 := Flat( List( ibls, x -> 
            ListBlist( pts, IntersectionBlist( u!.bmat[ x ], u!.bmat[ ib1 ] ) ) 
        ) );
        Add( fullpointsgens, Sortex( permblock1 ) );
    od;
    return Group(fullpointsgens);
end );

InstallOtherMethod( PerspectivityGroupOfUnitalsBlocks, "for an abstract unital and two blocks",
    [ IsAbstractUnitalDesign, IsList, IsList ],
function( u, b1, b2 )
    local ib1, ib2;
    ib1 := PositionSorted( BlocksOfUnital( u ), b1 );
    ib2 := PositionSorted( BlocksOfUnital( u ), b2 );
    if b1=b2 or b1 <> BlocksOfUnital( u )[ib1] or b2 <> BlocksOfUnital( u )[ib2] then 
        Error("arguments 2 and 3 must be different blocks of the unital");
    fi;
    return PerspectivityGroupOfUnitalsBlocks( u, b1, b2, FullPointsOfUnitalsBlocks( u, ib1, ib2 ) );
end );
