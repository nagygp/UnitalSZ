#
# AU libraries by Betten-Betten-Tonchev (order 3) and Krcadinac-Nakic-Pavcevic
# (order 4) and Krcadinac (order 3)
#
# Implementations
#

InstallGlobalFunction( AU_ReadLibraryDataFromFiles,
function( nr, q, filename )
    local v, nolines, myfile, myincmatlist, myincmat, i, currentline;
    v := q^3 + 1;
    nolines := nr * v;
    filename := Filename( DirectoriesPackageLibrary( "UnitalSZ", "data" ),
                        filename );
    if filename <> fail then
        myfile := IO_FilteredFile( [ [ "gzip", [ "-dc" ] ] ], filename, "r" );
    else
        filename := ReplacedString( filename, ".txt.gz", ".txt" );
        myfile := IO_File( filename, "r" );
    fi;
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

BindGlobal( "AU_LIBDATA_BBT", fail );
BindGlobal( "AU_LIBDATA_KNP", fail );
BindGlobal( "AU_LIBDATA_Krcadinac", fail );

InstallGlobalFunction( AU_InitLibraryData,
function()
    if AU_LIBDATA_BBT = fail then
        MakeReadWriteGlobal( "AU_LIBDATA_BBT" );
        UnbindGlobal( "AU_LIBDATA_BBT" );
        BindGlobal( "AU_LIBDATA_BBT",
                    AU_ReadLibraryDataFromFiles( 909, 3,
                                                 "betten_incmats.txt.gz" ) );
    fi;
    if AU_LIBDATA_KNP = fail then
        MakeReadWriteGlobal( "AU_LIBDATA_KNP" );
        UnbindGlobal( "AU_LIBDATA_KNP" );
        BindGlobal( "AU_LIBDATA_KNP",
                    AU_ReadLibraryDataFromFiles( 1777, 4,
                                                 "krcadinac_incmats.txt.gz" ) );
    fi;
    if AU_LIBDATA_Krcadinac = fail then
        MakeReadWriteGlobal( "AU_LIBDATA_Krcadinac" );
        UnbindGlobal( "AU_LIBDATA_Krcadinac" );
        BindGlobal( "AU_LIBDATA_Krcadinac",
                    AU_ReadLibraryDataFromFiles( 4466, 3,
                                                 "krcadinac_o3_incmats.txt.gz" ) );
    fi;
end );

BindGlobal( "AU_NrBBTUnitals", 909 );
BindGlobal( "AU_NrKNPUnitals", 1777 );
BindGlobal( "AU_NrKrcadinacUnitals", 4466 );

InstallGlobalFunction( BBTAbstractUnital,
function( n )
    local u;
    if not ( IsPosInt( n ) and n <= 909 ) then
        Error( "the BBT library knows 909 unitals" );
    fi;
    AU_InitLibraryData();
    u := AU_UnitalByBlistListNC( TransposedMat( AU_LIBDATA_BBT[ n ] ) );
    SetName( u, Concatenation( "BBTAbstractUnital(", String( n ), ")" ) );
    return u;
end );

InstallGlobalFunction( KNPAbstractUnital,
function( n )
    local u;
    if not ( IsPosInt( n ) and n <= 1777 ) then
        Error( "the KNP library knows 1777 unitals" );
    fi;
    AU_InitLibraryData();
    u := AU_UnitalByBlistListNC( TransposedMat( AU_LIBDATA_KNP[ n ] ) );
    SetName( u, Concatenation( "KNPAbstractUnital(", String( n ), ")" ) );
    return u;
end );

InstallGlobalFunction( KrcadinacAbstractUnital,
function( n )
    local u;
    if not ( IsPosInt( n ) and n <= 4466 ) then
        Error( "the Krcadinac library knows 4466 unitals" );
    fi;
    AU_InitLibraryData();
    u := AU_UnitalByBlistListNC( TransposedMat( AU_LIBDATA_Krcadinac[ n ] ) );
    SetName( u, Concatenation( "KrcadinacAbstractUnital(", String( n ), ")" ) );
    return u;
end );

InstallGlobalFunction( AbstractUnitalLibraryInfo,
function()
    Print( "# The UnitalSZ package has the following libraries of abstract unitals:\n" );
    Print( "#   909 unitals of order 3 by Betten-Betten-Tonchev: <BBTAbstractUnital(n)>\n" );
    Print( "#  1777 unitals of order 4 by Krcadinac-Nakic-Pavcevic: <KNPAbstractUnital(n)>\n" );
    Print( "#  4466 unitals of order 3 by Krcadinac: <KrcadinacAbstractUnital(n)>\n" );
end );
