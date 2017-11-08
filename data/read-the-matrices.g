ColorPrompt(true);
###############################################################################
#
# BitStringIntList( mystring )
#
# For a string consisting of 0s and 1s return a list with the corresponding
# integers, 0 and 1.
#
BitStringIntList := function( mystring )
    local integerlist;
    integerlist := List( mystring, c -> IntChar(c) - 48 );
    return integerlist;
end;

###############################################################################
#
# LoadIncMats( nmatrices, dim1, filename )
#
# Load a set of incidence matrices from a plain TXT file.
#
LoadIncMats := function( nmatrices, dim1, filename )
    local nolines, myfile, myincmatlist, myincmat, i, currentline;
    nolines := nmatrices * dim1;
    myfile := InputTextFile( filename );
    myincmatlist := [];
    myincmat := [];
    for i in [1..nolines] do
        currentline := Chomp( ReadLine( myfile ) );
        Add( myincmat, BitStringIntList( currentline ) );
        if i mod dim1 = 0 then
            Add( myincmatlist, myincmat );
            myincmat := [];
        fi;
    od;
    return myincmatlist;
end;

###############################################################################
betten_incmats := LoadIncMats( 909, 28, "data/betten_incmats.txt" );
krcadinac_incmats := LoadIncMats(1777, 65, "data/krcadinac_incmats.txt");
