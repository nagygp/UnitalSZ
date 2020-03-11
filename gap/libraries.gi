#
# AU libraries by Betten-Betten-Tonchev (order 3) and Krcadinac-Nakic-Pavcevic
# (order 4) and Krcadinac (order 3)
#
# Implementations
#

InstallGlobalFunction( ReadLibraryDataFromFiles@,
function( nr, q, filename )
    local v, nolines, myfile, myincmatlist, myincmat, i, currentline;
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

BindGlobal( "LIBDATA_BBT_AU", fail );
BindGlobal( "LIBDATA_KNP_AU", fail );
BindGlobal( "LIBDATA_Krcadinac_AU", fail );

InstallGlobalFunction( InitLibraryData@,
function()
    if LIBDATA_BBT_AU = fail then
        MakeReadWriteGlobal( "LIBDATA_BBT_AU" );
        UnbindGlobal( "LIBDATA_BBT_AU" );
        BindGlobal( "LIBDATA_BBT_AU",
                    ReadLibraryDataFromFiles@( 909, 3,
                                                 "betten_incmats.txt.gz" ) );
    fi;
    if LIBDATA_KNP_AU = fail then
        MakeReadWriteGlobal( "LIBDATA_KNP_AU" );
        UnbindGlobal( "LIBDATA_KNP_AU" );
        BindGlobal( "LIBDATA_KNP_AU",
                    ReadLibraryDataFromFiles@( 1777, 4,
                                                 "krcadinac_incmats.txt.gz" ) );
    fi;
    if LIBDATA_Krcadinac_AU = fail then
        MakeReadWriteGlobal( "LIBDATA_Krcadinac_AU" );
        UnbindGlobal( "LIBDATA_Krcadinac_AU" );
        BindGlobal( "LIBDATA_Krcadinac_AU",
                    ReadLibraryDataFromFiles@( 4466, 3,
                                                 "krcadinac_o3_incmats.txt.gz" ) );
    fi;
end );

BindGlobal( "NrBBTUnitals_AU", 909 );
BindGlobal( "NrKNPUnitals_AU", 1777 );
BindGlobal( "NrKrcadinacUnitals_AU", 4466 );

InstallGlobalFunction( BBTAbstractUnital,
function( n )
    local u;
    if not ( IsPosInt( n ) and n <= 909 ) then
        Error( "the BBT library knows 909 unitals" );
    fi;
    InitLibraryData@();
    u := UnitalByBlistListNC@( TransposedMat( LIBDATA_BBT_AU[ n ] ) );
    SetName( u, Concatenation( "BBTAbstractUnital(", String( n ), ")" ) );
    return u;
end );

InstallGlobalFunction( KNPAbstractUnital,
function( n )
    local u;
    if not ( IsPosInt( n ) and n <= 1777 ) then
        Error( "the KNP library knows 1777 unitals" );
    fi;
    InitLibraryData@();
    u := UnitalByBlistListNC@( TransposedMat( LIBDATA_KNP_AU[ n ] ) );
    SetName( u, Concatenation( "KNPAbstractUnital(", String( n ), ")" ) );
    return u;
end );

InstallGlobalFunction( KrcadinacAbstractUnital,
function( n )
    local u;
    if not ( IsPosInt( n ) and n <= 4466 ) then
        Error( "the Krcadinac library knows 4466 unitals" );
    fi;
    InitLibraryData@();
    u := UnitalByBlistListNC@( TransposedMat( LIBDATA_Krcadinac_AU[ n ] ) );
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
