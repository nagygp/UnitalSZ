###############################################################################
##  FULL POINTS
##  ---------------------------------------------------------------------------
#
# fullpoints: Full points of unitals
#
# Implementations
#

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
    ib1 := PositionSorted( BlocksOfUnital( u ), b1 );
    ib2 := PositionSorted( BlocksOfUnital( u ), b2 );
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
    orbs := Set( orbs );
    Info( InfoUnitalSZ, 2, Concatenation( String( Length( orbs ) ), " block pair(s) up to automorphisms computed" ) );
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
            Info( InfoUnitalSZ, 2, Concatenation( String( Length( lsfullpoints ) ), " full point(s) found" ) );
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

InstallMethod( EmbeddedDual3NetsOfUnitalRepresentatives, "for an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    local fullpts, ed3nets, thirdblocks, fp, b3;
    fullpts := Filtered( FullPointsOfUnitalRepresentatives( u ),
                         x -> ForAny( BlocksOfUnital( u ),
                                      b -> IsSubset( x.fullpts, b ) ) );
    ed3nets := [];
    for fp in fullpts do
        thirdblocks := Filtered( BlocksOfUnital( u ),
                                 b -> IsSubset( fp.fullpts, b ) );
        for b3 in thirdblocks do
            Add( ed3nets, SortedList( [ fp.block1, fp.block2, b3 ] ) );
        od;
    od;
    return Set( ed3nets );
end );

InstallOtherMethod( LatinSquareOfEmbeddedDual3Net, "for an abstract unital and an embedded dual 3-net",
    [ IsAbstractUnitalDesign, IsList ],
function( u, ed3net )
    local n, b1, b2, b3, latinsquare, block, p, permcols, permrows, i, j;
##  If the unital u has order q then the blocks contain n = q + 1 points
    n := Order( u ) + 1;
    b1 := ed3net[1];
    b2 := ed3net[2];
    b3 := ed3net[3];
    
    if Intersection( b1, b2 ) <> [] or Intersection( b1, b3 ) <> [] or
       Intersection( b2, b3 ) <> [] then
        Error( "The blocks in an embedded dual 3-net must be pairwise disjoint" );
    fi;

    latinsquare := List( [ 1..n ], x -> EmptyPlist( n ) );

##  For each pair of points from the blocks b1 and b2 we compute the unique
##  block containing both points and the (unique) intersection of this block
##  with b3. Then the (i, j)th element of the latin square is the "position" of
##  the intersection p in the block b3. 
    for i in [ 1..n ] do
        for j in [ 1..n ] do
            block := First( BlocksOfUnital( u ),
                            x -> IsSubset( x, [b1[i], b2[j]] ) );
            p := Intersection( block, b3 );
            if p = [] then
                Error( "The given blocks do not form an abstract polar triangle" );
            else
                latinsquare[i][j] := Position( b3, p[1] );
            fi;
        od;
    od;
    permcols := PermutationMat( PermList( latinsquare[1] ), n );
    latinsquare := latinsquare * permcols;
    permrows := PermutationMat( PermList( TransposedMat( latinsquare )[1] ), n );
    latinsquare := TransposedMat( permrows ) * latinsquare;
    return latinsquare;
end );

InstallMethod( IsFullPointRegularUnital, "an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    local fp, reginfo;
    fp := Filtered( FullPointsOfUnitalRepresentatives( u ),
                    r -> Size( Intersection( r.block1, r.block2 ) ) = 0 );
    return ForAll( fp,
                   r -> ForAny( BlocksOfUnital( u ),
                                c -> IsSubset( c, r.fullpts ) and
                                     Size( Intersection( r.block1, c ) ) = 0 and
                                     Size( Intersection( r.block2, c ) ) = 0 ) );
end );

InstallMethod( IsStronglyFullPointRegularUnital, "an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    local fp, persp_group, r;
    if not IsFullPointRegularUnital( u ) then
        return false;
    fi;
    fp := Filtered( FullPointsOfUnitalRepresentatives( u ),
                    r -> Size( Intersection( r.block1, r.block2 ) ) = 0 );
    for r in fp do
        persp_group := PerspectivityGroupOfUnitalsBlocks( u, r.block1,
                                                          r.block2, r.fullpts );
        if not ( IsSemiRegular( persp_group ) and IsCyclic( persp_group ) ) then
            return false;
        fi;
    od;
    return true;
end );
