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
    ),
    P3M := rec(
        order := 3,
        nr := 173,
        owner := "Mezőfi-Nagy",
        callby := "P3MAbstractUnital(n)",
        filename := "p3m-n173.txt.gz"
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

InstallGlobalFunction( ReadAbstractUnitalFromLibraryNC@,
function( name, n )
    local u, uname;
    if not IsBound( LIBDATA@.(name).matrices ) then
        LIBDATA@.(name).matrices := 
            ReadLibraryDataFromFiles@( LIBDATA@.(name)  );
    fi;
    u := UnitalByBlistListNC@( TransposedMat( LIBDATA@.(name).matrices[ n ] ) );
    uname := ReplacedString( 
        LIBDATA@.(name).callby, 
        "(n)",
        Concatenation( "(", String( n ), ")" )
    );
    SetName( u, uname );
    return u;
end );

############################################

InstallGlobalFunction( BBTAbstractUnital,
function( n )
    if not ( IsPosInt( n ) and n <= 909 ) then
        Error( "the BBT library knows 909 unitals" );
    fi;
    return ReadAbstractUnitalFromLibraryNC@( "BBT", n );
end );

InstallGlobalFunction( KNPAbstractUnital,
function( n )
    if not ( IsPosInt( n ) and n <= 1777 ) then
        Error( "the KNP library knows 1777 unitals" );
    fi;
    return ReadAbstractUnitalFromLibraryNC@( "KNP", n );
end );

InstallGlobalFunction( KrcadinacAbstractUnital,
function( n )
    if not ( IsPosInt( n ) and n <= 4466 ) then
        Error( "the Krcadinac library knows 4466 unitals" );
    fi;
    return ReadAbstractUnitalFromLibraryNC@( "Krcadinac", n );
end );

InstallGlobalFunction( P3MAbstractUnital,
function( n )
    if not ( IsPosInt( n ) and n <= 173 ) then
        Error( "the P3M library knows 173 unitals" );
    fi;
    return ReadAbstractUnitalFromLibraryNC@( "P3M", n );
end );
