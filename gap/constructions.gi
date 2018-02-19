#
# Constructions of different classes of abstract unitals
#
# Implementations
#

InstallGlobalFunction( HermitianAbstractUnital,
function( q )
    local pgl, bls, u;
    pgl := PGU( 3, q );
    pgl := Action( pgl, First( Orbits( pgl ), x -> Length( x ) = q^3 + 1 ) );
    bls := Union( [ 1, 2 ], First( Orbits( Stabilizer( pgl, [ 1, 2 ],
                                                       OnTuples ) ),
                                   x -> Length( x ) = q - 1 ) );
    bls :=Set( Orbit( pgl, bls, OnSets ) );
    u := AbstractUnitalByDesignBlocks( bls );
    SetName( u, Concatenation( "HermitianAbstractUnital(", String( q ),
                               ")" ) );
    return u;
end );

InstallGlobalFunction( AllBuekenhoutMetzAbstractUnitalParameters,
function( q )
    local y, filt, parampairs;
    if not IsPrimePowerInt( q ) then
        Error( "the argument must be a prime power" );
    fi;
    if IsOddInt( q ) then
        y := X( GF(q), "y" );
        filt := Filtered( Tuples( GF(q^2), 2 ), c -> c[1] <> Zero(GF(q^2)) );
        parampairs := Filtered( filt,
                                c -> RootsOfUPol( GF(q),
                                                  y^2 - ((c[2]^q - c[2])^2 +
                                                  4 * c[1]^(q + 1)) )
                                     = [] );
    fi;
    if IsEvenInt( q ) then
        filt := Filtered( Tuples( GF(q^2), 2 ), c -> c[1] <> Zero(GF(q^2)) and
                                                     not ( c[2] in GF(q) ) );
        parampairs := Filtered( filt,
                                c -> Trace( GF(q), c[1]^(q + 1) / (c[2]^q +
                                                   c[2])^2 )
                                     = Zero( GF(2) ) );
    fi;
    return parampairs;
end );

InstallGlobalFunction( BuekenhoutTitsAbstractUnital,
function(q)
    local tau, delta, bt_points, xy, v, bmat, a, line, blist, mb, u;
    if not IsPrimePowerInt( q ) or IsOddInt( q ) then
        Error( "the parameter must be power of 2 with odd exponent at least 3" );
    fi;
    if IsEvenInt( Dimension( GF(q) ) ) then
        Error( "the parameter must be power of 2 with odd exponent at least 3" );
    fi;
    tau := 2^( (Dimension( GF(q) ) + 1) / 2 );
    delta := First( GF(q^2), d -> d^q=d+1 and d<>d^(q-1) );
    bt_points := [];
    for xy in Tuples( GF(q), 3 ) do;
        v := [ xy[1] + xy[2]*delta,
               xy[3] + ( xy[1]^( tau + 2 ) + xy[2]^tau + xy[1]*xy[2] )*delta,
               One(GF(q^2)) ];
        Add( bt_points, v );
    od;
    v := [ Zero(GF(q^2)), One(GF(q^2)), Zero(GF(q^2)) ];
    Add( bt_points, v );
    bmat := [];
    for a in GF(q^2) do;
        line := [ One(GF(q^2)), Zero(GF(q^2)), a ];
        blist := List( bt_points, p -> line * p = Zero(GF(q^2)) );
        if SizeBlist( blist ) = q + 1 then
            Add( bmat, blist );
        fi;
    od;
    for mb in Tuples( GF(q^2), 2 ) do;
        line := [ mb[1], One(GF(q^2)), mb[2] ];
        blist := List( bt_points, p -> line * p = Zero(GF(q^2)) );
        if SizeBlist( blist ) = q + 1 then
            Add( bmat, blist );
        fi;
    od;
    u := AbstractUnitalByBlistList( bmat );
    SetName( u, Concatenation( "BuekenhoutTitsAbstractUnital(", String(q), ")" ) );
    SetPointNamesOfUnital( u, bt_points );
    return u;
end );
