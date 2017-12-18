#
# UnitalSZ: Algorithms and library of unitals of projective planes
#
# Implementations
#

###############################################################################
##  UTILITIES
##  ---------------------------------------------------------------------------

InstallGlobalFunction( AU_UnitalBlistList_axiomcheck,
function( bmat )
    local bmattr, q, i, j;
    q := SizeBlist( bmat[ 1 ] ) - 1;
    if ForAny( bmat, x -> SizeBlist( x ) <> q + 1 ) then
        return false;
    fi;
    bmattr := TransposedMat( bmat );
    for i in [ 1..q^3 ] do
        for j in [ i + 1..q^3 + 1 ] do
            if SizeBlist( IntersectionBlist( bmattr[ i ],
                                             bmattr[ j ] ) ) <> 1 then
                return false;
            fi;
        od;
    od;
    return true;
end );

InstallGlobalFunction( IsAU_UnitalBlistList,
function( bmat )
    local q, i, j;
    q := SizeBlist( bmat[ 1 ] ) - 1;
    if Length( bmat ) <> q^2 * ( q^2 - q + 1 ) or
       ForAny( bmat, x -> Length( x ) <> q^3 + 1 ) then
        Error("wrong bmat size");
    fi;
    return AU_UnitalBlistList_axiomcheck( bmat );
end );

InstallGlobalFunction( IsAU_UnitalIncidenceMatrix,
function( incmat )
    local q, bmat;
    bmat := List( incmat, x -> List( x, IsOne ) );
    q := SizeBlist( bmat[ 1 ] ) - 1;
    if Length( bmat ) <> q^2 * ( q^2 - q + 1 ) or
       ForAny( bmat, x -> Length( x ) <> q^3 + 1 ) then
        Error( "wrong incmat size" );
    fi;
    return AU_UnitalBlistList_axiomcheck(bmat);
end );

InstallGlobalFunction( IsAU_UnitalBlockDesign,
function( bls )
    local q, bmat, pts;
    pts := Union( bls );
    q := Size( bls[ 1 ] ) - 1;
    if Length( bls ) <> q^2 * ( q^2 - q + 1 ) or Size( pts ) <> q^3 + 1 then
        Error( "wrong number of PointsOfUnital or blocks" );
    fi;
    bmat := List( bls, b -> BlistList( pts, b ) );
    return AU_UnitalBlistList_axiomcheck( bmat );
end );

###############################################################################
##  CONSTRUCTORS
##  ---------------------------------------------------------------------------

InstallGlobalFunction( AU_UnitalByBlistListNC,
function( bmat )
    local q, uni;
    q := SizeBlist( bmat[ 1 ] ) - 1;
    uni := Objectify( NewType( AU_UnitalDesignFamily, IsAU_UnitalDesign and
                               IsAU_UnitalDesignRep ),
                      rec( bmat := Set( bmat ) ) );
    SetOrder( uni, q );
    return uni;
end );

InstallGlobalFunction( AU_UnitalByBlistList,
function( bmat )
    if IsAU_UnitalBlistList( bmat ) then
        return AU_UnitalByBlistListNC( bmat );
    else
        Error( "argument must be the blist list of an abstract unital" );
    fi;
end );

InstallGlobalFunction( AU_UnitalByDesignBlocks,
function( bls )
    local q, bmat, pts, u;
    pts := Union( bls );
    q := Size( bls[ 1 ] ) - 1;
    if Length( bls ) <> q^2 * ( q^2 - q + 1 ) then
        Error( "wrong number of blocks" );
    fi;
    bmat := List( bls, b -> BlistList( pts, b ) );
    if AU_UnitalBlistList_axiomcheck( bmat ) then
        u := AU_UnitalByBlistListNC( bmat );
    else
        Error( "argument must be the list of blocks of an abstract unital" );
    fi;
    SetPointsOfUnital( u, pts );
    SetBlocksOfUnital( u, bls );
    return u;
end );

InstallGlobalFunction( AU_UnitalByIncidenceMatrix,
function( incmat )
    local q, bmat;
    bmat := List( incmat, x -> List( x, IsOne ) );
    q := SizeBlist( bmat[ 1 ] ) - 1;
    if Length( bmat ) <> q^2 * ( q^2 - q + 1 ) or
       ForAny( bmat, x -> Length( x ) <> q^3 + 1 ) then
        Error( "wrong incmat size" );
    fi;
    if AU_UnitalBlistList_axiomcheck( bmat ) then
        return AU_UnitalByBlistListNC( bmat );
    else
        Error( "argument must be the incident matrix of an abstract unital" );
    fi;
end );

InstallGlobalFunction( AU_HermitianAbstractUnital,
function( q )
    local pgl, bls, u;
    pgl := PGU( 3, q );
    pgl := Action( pgl, First( Orbits( pgl ), x -> Length( x ) = q^3 + 1 ) );
    bls := Union( [ 1, 2 ], First( Orbits( Stabilizer( pgl, [ 1, 2 ],
                                                       OnTuples ) ),
                                   x -> Length( x ) = q - 1 ) );
    bls :=Set( Orbit( pgl, bls, OnSets ) );
    u := AU_UnitalByDesignBlocks( bls );
    SetName( u, Concatenation( "AU_HermitianAbstractUnital(", String( q ),
                               ")" ) );
    return u;
end );

###############################################################################
##  DISPLAYING AND COMPARING ELEMENTS
##  ---------------------------------------------------------------------------

InstallMethod( ViewObj, "for an abstract unital",
    [ IsAU_UnitalDesign ],
function( u )
    Print( "AU_UnitalDesign<", Order( u ), ">" );
end );

InstallMethod( Display, "for an abstract unital",
    [ IsAU_UnitalDesign ],
function( u )
    Print( "Abstract unital of order ", Order( u ) );
end );

InstallMethod( PrintObj, "for an abstract unital",
    [ IsAU_UnitalDesign ],
function( u )
    Print( "AU_UnitalDesign<", Order( u ), ">" );
end );

InstallMethod( \=, "for two abstract unitals",
    IsIdenticalObj,
    [ IsAU_UnitalDesign, IsAU_UnitalDesign ],
function( u1, u2 )
    return u1!.bmat = u2!.bmat;
end );

InstallMethod( \<, "for two abstract unitals",
    IsIdenticalObj,
    [ IsAU_UnitalDesign, IsAU_UnitalDesign ],
    function( u1, u2 )
        return u1!.bmat < u2!.bmat;
end );

###############################################################################
##  BLOCKS, PointsOfUnital, INCIDENT DIGRAPHS, FULL PointsOfUnital
##  ---------------------------------------------------------------------------

InstallMethod( PointsOfUnital, "for an abstract unital",
    [ IsAU_UnitalDesign ],
function( u )
    return [ 1..Order( u )^3 + 1 ];
end );

InstallMethod( BlocksOfUnital, "for an abstract unital",
    [ IsAU_UnitalDesign ],
function( u )
    return Set( u!.bmat, x -> ListBlist( PointsOfUnital( u ), x ) );
end );

InstallMethod( IncidenceDigraph, "for an abstract unital",
    [ IsAU_UnitalDesign ],
function( u )
    local q;
    q := Order( u );
    return Digraph( [ 1..q^3 + 1 + q^2 * ( q^2 - q + 1 ) ],
                    function( x, y )
                        return x <= q^3 + 1 and y > q^3 + 1 and
                               u!.bmat[ y - q^3 - 1 ][ x ];
                    end );
end );

InstallMethod( AU_FullPointsNumberRepresentation, "for an abstract unital",
    [ IsAU_UnitalDesign ],
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

InstallMethod( AU_FullPoints, "for an abstract unital",
    [ IsAU_UnitalDesign ],
function( u )
    local lsfullpoints, r;
    lsfullpoints := [];
    for r in AU_FullPointsNumberRepresentation( u ) do
        Add( lsfullpoints,
             rec( block1 := AU_Blocks( u )[ r.block1 ],
                  block2 := AU_Blocks( u )[ r.block2 ],
                  fullpts := List( r.fullpts, x -> AU_Points( u )[ x ] ) ) );
    od;
    return lsfullpoints;
end );

###############################################################################
##  ACTIONS, AUTOMORPHISMS
##  ---------------------------------------------------------------------------

InstallOtherMethod( \^, "for an abstract unitals and a permutation",
    [ IsAU_UnitalDesign, IsPerm ],
    function( u, perm )
        return AU_UnitalByBlistListNC( List( u!.bmat,
                                             x -> Permuted( x, perm ) ) );
end );

InstallMethod( AutomorphismGroup, "for an abstract unital",
    [ IsAU_UnitalDesign ],
function( u )
    local g;
    g := AutomorphismGroup( IncidenceDigraph( u ) );
    return Action( g, [ 1..Order( u )^3 + 1 ] );
end );

InstallMethod( Isomorphism, "for two abstract unitals",
    [ IsAU_UnitalDesign, IsAU_UnitalDesign ],
    function( u1, u2 )
        local ret;
        if Order( u1 ) <> Order( u2 ) then
            return fail;
        fi;
        ret := IsomorphismDigraphs( IncidenceDigraph( u1 ),
                                    IncidenceDigraph( u2 ) );
        if ret = fail then
            return fail;
        else
            return RestrictedPerm( ret, [ 1..Order( u1 )^3 + 1 ] );
        fi;
end );

InstallMethod( AU_FullPointsGenerators, "for an abstract unital",
    [ IsAU_UnitalDesign ],
function( u )
    local bmattr, pts, bls, lsfullpoints, lsfullpointsgens, i, p, ibls,
          imblock1, fullpointsgens, permblock1;
    bmattr := TransposedMat( u!.bmat );
    pts := [ 1..Order( u )^3 + 1 ];
    bls := [ 1..Order( u )^2 * ( Order( u )^2 - Order( u ) + 1 ) ];
    lsfullpoints := AU_FullPointsNumberRepresentation( u );
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
