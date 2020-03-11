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