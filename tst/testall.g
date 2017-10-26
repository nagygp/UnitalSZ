#
# UnitalSZ: Algorithms and library of unitals of projective planes
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "UnitalSZ" );

TestDirectory(DirectoriesPackageLibrary( "UnitalSZ", "tst" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
