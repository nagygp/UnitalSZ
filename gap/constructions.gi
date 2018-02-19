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
