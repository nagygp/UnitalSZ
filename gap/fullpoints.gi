###############################################################################
##  ACTIONS, AUTOMORPHISMS
##  ---------------------------------------------------------------------------

InstallMethod( FullPointsOfUnital, "for an abstract unital",
    [ IsAU_UnitalDesign ],
function( u )
    local bmattr, pts, nobls, bls, lsfullPointsOfUnital, i, j, blocki, pblocki, blockj,
          pblockj, nonincpts, fullPointsOfUnital, p, bp, ibls, coveredpts;
    bmattr := TransposedMat( u!.bmat );
    pts := [ 1..Order( u )^3 + 1 ];
    nobls := Order( u )^2 * ( Order( u )^2 - Order( u ) + 1 );
    bls := [ 1..nobls ];
    lsfullPointsOfUnital := [];
    for i in [ 1..( nobls - 1 ) ] do
        blocki := u!.bmat[ i ];
        pblocki := ListBlist( pts, blocki );
        for j in [ ( i + 1 )..nobls ] do
            blockj := u!.bmat[ j ];
            pblockj := ListBlist( pts, blockj );
            nonincpts := ListBlist( pts, List( UnionBlist( blocki, blockj ),
                                               x -> not x ) );
            fullPointsOfUnital := [];
            for p in nonincpts do
                bp := ListBlist( bls, bmattr[ p ] );
                ibls := Filtered( bp, x -> SizeBlist( IntersectionBlist(
                        u!.bmat[ x ], blocki ) ) > 0 );
                coveredpts := Flat( List( ibls, x -> ListBlist( pts,
                              IntersectionBlist( u!.bmat[ x ], blockj ) ) ) );
                if pblockj = Set( coveredpts ) then
                    Add( fullPointsOfUnital, p );
                fi;
            od;
            if Length( fullPointsOfUnital ) <> 0 then
                Apply( fullPointsOfUnital, x -> PointsOfUnital( u )[ x ] );
                Add( lsfullPointsOfUnital, rec( block1 := BlocksOfUnital( u )[ i ],
                                        block2 := BlocksOfUnital( u )[ j ],
                                        fullpts := fullPointsOfUnital ) );
            fi;
        od;
    od;
    return lsfullPointsOfUnital;
end );