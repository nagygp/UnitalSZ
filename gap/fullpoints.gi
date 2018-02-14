###############################################################################
##  FULL POINTS
##  ---------------------------------------------------------------------------

InstallMethod( FullPointsOfUnitalRepresentatives, "for an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    local bmattr, pts, nobls, bls, lsfullpoints, i, j, blocki, blockj,
          nonincpts, fullpoints, p, bp, ibls, coveredpts;
    bmattr := TransposedMat( u!.bmat );
    pts := [ 1..Order( u )^3 + 1 ];
    nobls := Order( u )^2 * ( Order( u )^2 - Order( u ) + 1 );
    bls := [ 1..nobls ];
    lsfullpoints := [];
    for i in [ 1..( nobls - 1 ) ] do
        blocki := u!.bmat[ i ];
        for j in [ ( i + 1 )..nobls ] do
            blockj := u!.bmat[ j ];
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
                Add( lsfullpoints, rec( block1 := i, block2 := j,
                                        fullpts := fullpoints ) );
            fi;
        od;
    od;
    return lsfullpoints;
end );

InstallMethod( FullPointsOfUnital, "for an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    local lsfullpoints, r;
    lsfullpoints := [];
    for r in FullPointsOfUnitalRepresentatives( u ) do
        Add( lsfullpoints,
             rec( block1 := BlocksOfUnital( u )[ r.block1 ],
                  block2 := BlocksOfUnital( u )[ r.block2 ],
                  fullpts := List( r.fullpts,
                                   x -> PointsOfUnital( u )[ x ] ) ) );
    od;
    return lsfullpoints;
end );

InstallMethod( GeneratorsOfProjectivityGroupsOfUnital, "for an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    local bmattr, pts, bls, lsfullpoints, lsfullpointsgens, i, p, ibls,
          imblock1, fullpointsgens, permblock1;
    bmattr := TransposedMat( u!.bmat );
    pts := [ 1..Order( u )^3 + 1 ];
    bls := [ 1..Order( u )^2 * ( Order( u )^2 - Order( u ) + 1 ) ];
    lsfullpoints := FullPointsOfUnitalRepresentatives( u );
    lsfullpointsgens := [];
    for i in lsfullpoints do
        p := i.fullpts[ 1 ];
        ibls := Flat( List( ListBlist( pts, u!.bmat[ i.block1 ] ),
                            x -> ListBlist( bls, IntersectionBlist(
                                 bmattr[ p ], bmattr[ x ] ) ) ) );
        imblock1 := Flat( List( ibls,
                                x -> ListBlist( pts, IntersectionBlist(
                                     u!.bmat[ x ], u!.bmat[ i.block2 ] ) ) ) );
        fullpointsgens := [];
        for p in i.fullpts do
            ibls := Flat( List( imblock1, x -> ListBlist( bls,
                                               IntersectionBlist( bmattr[ p ],
                                               bmattr[ x ] ) ) ) );
            permblock1 := Flat( List( ibls,
                                      x -> ListBlist( pts, IntersectionBlist(
                                      u!.bmat[ x ], u!.bmat[ i.block1 ] ) ) ) );
            Add( fullpointsgens, Sortex( permblock1 ) );
        od;
        Add( lsfullpointsgens, rec( block1 := i.block1,
                                    block2 := i.block2,
                                    fullpts := i.fullpts,
                                    fullptsgens := fullpointsgens ) );
    od;
    return lsfullpointsgens;
end );
