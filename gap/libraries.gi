#
# Abstract unital libraries by Betten-Betten-Tonchev (order 3) and Krcadinac-Nakic-Pavcevic
# (order 4) and Krcadinac (order 3)
#
# Implementations
#

InstallGlobalFunction( ReadLibraryDataFromFiles@,
function( data )
    local v, nolines, myfile, myincmatlist, myincmat, i, currentline, 
        nr, q, filename;
    nr := data.nr;
    q := data.order;
    filename := data.filename;
    v := q^3 + 1;
    nolines := nr * v;
    filename := Filename( DirectoriesPackageLibrary( "UnitalSZ", "data" ),
                        filename );
    myfile := IO_FilteredFile( [ [ "gzip", [ "-dc" ] ] ], filename, "r" );
    myincmatlist := [ ];
    myincmat := [ ];
    for i in [ 1..nolines ] do
        currentline := Chomp( IO_ReadLine( myfile ) );
        currentline := List( currentline, x -> x = '1' );
        Add( myincmat, currentline );
        if i mod v = 0 then
            Add( myincmatlist, myincmat );
            myincmat := [ ];
        fi;
    od;
    IO_Close( myfile );
    return myincmatlist;
end );

############################################
# Central source for library data
# Start here to add new libraries
LIBDATA@ := rec(
    BBT := rec( 
        order := 3,
        nr := 909,
        owner := "Betten-Betten-Tonchev",
        callby := "BBTAbstractUnital(n)",
        filename := "betten_incmats.txt.gz"
    ),
    KNP := rec( 
        order := 4,
        nr := 1777,
        owner := "Krcadinac-Nakic-Pavcevic",
        callby := "KNPAbstractUnital(n)",
        filename := "krcadinac_incmats.txt.gz"
    ),
    Krcadinac := rec( 
        order := 3,
        nr := 4466,
        owner := "Krcadinac",
        callby := "KrcadinacAbstractUnital(n)",
        filename := "krcadinac_o3_incmats.txt.gz"
    )
);
############################################

InstallGlobalFunction( AbstractUnitalLibraryInfo,
function()
    local n;
    Print( "# The UnitalSZ package has the following libraries of abstract unitals:\n" );
    for n in RecNames( LIBDATA@ ) do
        Print( "# ", PrintString( LIBDATA@.(n).nr, 5 ) );
        Print( " unitals of order ", LIBDATA@.(n).order );
        Print( " by ", LIBDATA@.(n).owner, ": ");
        Print( "<", LIBDATA@.(n).callby , ">" );
        Print( "\n" );
    od;
end );

InstallGlobalFunction( NumberOfAbstractUnitalsInLibrary,
function( name )
    if IsBound( LIBDATA@.(name) ) then
        return LIBDATA@.(name).nr;
    else
        Error( "no abstract unital library with this name" );
    fi;
end );

############################################

InstallGlobalFunction( BBTAbstractUnital,
function( n )
    local u;
    if not ( IsPosInt( n ) and n <= 909 ) then
        Error( "the BBT library knows 909 unitals" );
    fi;
    if not IsBound( LIBDATA@.BBT.matrices ) then
        LIBDATA@.BBT.matrices := 
            ReadLibraryDataFromFiles@( LIBDATA@.BBT  );
    fi;
    u := UnitalByBlistListNC@( TransposedMat( LIBDATA@.BBT.matrices[ n ] ) );
    SetName( u, Concatenation( "BBTAbstractUnital(", String( n ), ")" ) );
    return u;
end );

InstallGlobalFunction( KNPAbstractUnital,
function( n )
    local u;
    if not ( IsPosInt( n ) and n <= 1777 ) then
        Error( "the KNP library knows 1777 unitals" );
    fi;
    if not IsBound( LIBDATA@.KNP.matrices ) then
        LIBDATA@.KNP.matrices := 
            ReadLibraryDataFromFiles@( LIBDATA@.KNP );
    fi;
    u := UnitalByBlistListNC@( TransposedMat( LIBDATA@.KNP.matrices[ n ] ) );
    SetName( u, Concatenation( "KNPAbstractUnital(", String( n ), ")" ) );
    return u;
end );

InstallGlobalFunction( KrcadinacAbstractUnital,
function( n )
    local u;
    if not ( IsPosInt( n ) and n <= 4466 ) then
        Error( "the Krcadinac library knows 4466 unitals" );
    fi;
    if not IsBound( LIBDATA@.Krcadinac.matrices ) then
        LIBDATA@.Krcadinac.matrices := 
            ReadLibraryDataFromFiles@( LIBDATA@.Krcadinac );
    fi;
    u := UnitalByBlistListNC@( TransposedMat( LIBDATA@.Krcadinac.matrices[ n ] ) );
    SetName( u, Concatenation( "KrcadinacAbstractUnital(", String( n ), ")" ) );
    return u;
end );


