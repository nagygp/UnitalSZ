###############################################################################
BmatrixToZeroOneMatrix := function( bmat );
  return List( bmat,
               row -> List( row, function( x ) if x then return 1; else return 0; fi; end ) );
end;
###############################################################################
ExportUnitals := function( unitals, filename )
  local file, incmat, u, line;
  file := IO_CompressedFile( filename, "w" );
  for u in unitals do
    incmat := TransposedMat( BmatrixToZeroOneMatrix( u!.bmat ) );
    for line in incmat do
      IO_WriteLine( file, Concatenation( List( line, x -> String( x ) ) ) );
    od;
  od;
  return IO_Close( file );
end;
###############################################################################
ExportUnitalsAppend := function( unitals, filename )
  local file, incmat, u, line;
  file := IO_CompressedFile( filename, "a" );
  for u in unitals do
    incmat := TransposedMat( BmatrixToZeroOneMatrix( u!.bmat ) );
    for line in incmat do
      IO_WriteLine( file, Concatenation( List( line, x -> String( x ) ) ) );
    od;
  od;
  return IO_Close( file );
end;
###############################################################################