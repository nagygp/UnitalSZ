###############################################################################
##  ACTIONS, AUTOMORPHISMS
##  ---------------------------------------------------------------------------

InstallMethod( AU_FullPoints, "for an abstract unital",
    [ IsAU_UnitalDesign ],
function( u )
    local bmattr, pts, nobls, bls, lsfullpoints, i, j, blocki, pblocki, blockj,
          pblockj, nonincpts, fullpoints, p, bp, ibls, coveredpts;
    bmattr := TransposedMat( u!.bmat );
    pts := [ 1..Order( u )^3 + 1 ];
    nobls := Order( u )^2 * ( Order( u )^2 - Order( u ) + 1 );
    bls := [ 1..nobls ];
    lsfullpoints := [];
    for i in [ 1..( nobls - 1 ) ] do
        blocki := u!.bmat[ i ];
        pblocki := ListBlist( pts, blocki );
        for j in [ ( i + 1 )..nobls ] do
            blockj := u!.bmat[ j ];
            pblockj := ListBlist( pts, blockj );
            nonincpts := ListBlist( pts, List( UnionBlist( blocki, blockj ),
                                               x -> not x ) );
            fullpoints := [];
            for p in nonincpts do
                bp := ListBlist( bls, bmattr[ p ] );
                ibls := Filtered( bp, x -> SizeBlist( IntersectionBlist(
                        u!.bmat[ x ], blocki ) ) > 0 );
                coveredpts := Flat( List( ibls, x -> ListBlist( pts,
                              IntersectionBlist( u!.bmat[ x ], blockj ) ) ) );
                if pblockj = Set( coveredpts ) then
                    Add( fullpoints, p );
                fi;
            od;
            if Length( fullpoints ) <> 0 then
                Apply( fullpoints, x -> AU_Points( u )[ x ] );
                Add( lsfullpoints, rec( block1 := AU_Blocks( u )[ i ],
                                        block2 := AU_Blocks( u )[ j ],
                                        fullpts := fullpoints ) );
            fi;
        od;
    od;
    return lsfullpoints;
end );