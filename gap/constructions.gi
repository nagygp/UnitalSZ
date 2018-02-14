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

