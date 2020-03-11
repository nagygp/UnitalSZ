#
# AU libraries by Betten-Betten-Tonchev (order 3) and Krcadinac-Nakic-Pavcevic
# (order 4)
#
# Declarations
#

#! @ChapterInfo Libraries and classes of abstract unitals, Global functions for internal usage
#! @Arguments nr, q, filename
#! @Returns
#!  The list of boolean incidence matrices of size $(q^3 + 1) \times q^2(q^2 -
#!  q + 1)$ read from <A>filename</A>.
#! @Description
#!  The file <A>filename</A> must be gzipped and must contain <A>nr</A>
#!  matrices of dimension mentioned above. The matrices must be 0-1 matrices
#!  without any whitespace between the entries in one row and there must not be
#!  any empty lines between matrices.
DeclareGlobalFunction( "ReadLibraryDataFromFiles@" );

#! @ChapterInfo Libraries and classes of abstract unitals, Global functions for internal usage
#! @Arguments 
#! @Description
#!   Reads in the incidence matrices from the libraries of unitals shipped with
#!   the package.
DeclareGlobalFunction( "InitLibraryData@" );

#####################################################
#####################################################

#! @ChapterInfo Libraries and classes of abstract unitals, Libraries
#! @Arguments n
#! @Returns
#!   The <A>n</A>th (abstract) unital of order 3 of the unitals by Betten,
#!   Betten and Tonchev.
#! @Description
#!   In the paper <Cite Key="BBT2003"/> by Betten, Betten and Tonchev, 909 unitals of order 3
#!   were constructed. The incidence matrices of these unitals are shipped with
#!   the package.
DeclareGlobalFunction( "BBTAbstractUnital" );

#! @ChapterInfo Libraries and classes of abstract unitals, Libraries
#! @Arguments n
#! @Returns
#!   The <A>n</A>th (abstract) unital of order 4 of the unitals by Krčadinac,
#!   Nakić and Pavčević.
#! @Description
#!   In the paper <Cite Key="KNP2011"/> by Krčadinac, Nakić and Pavčević, 1777 unitals
#!   of order 4 were constructed. The incidence matrices of these unitals are
#!   shipped with the package.
DeclareGlobalFunction( "KNPAbstractUnital" );

#! @ChapterInfo Libraries and classes of abstract unitals, Libraries
#! @Arguments n
#! @Returns
#!   The <A>n</A>th (abstract) unital of order 3 of the unitals by Krčadinac.
#! @Description
#!   In the paper <Cite Key="Krc2006"/> by Krčadinac, 4466
#!   unitals of order 3 were constructed. This library contains all the unitals
#!   of order 3 with nontrivial automorphism group. The incidence matrices of
#!   these unitals are shipped with the package.
DeclareGlobalFunction( "KrcadinacAbstractUnital" );

#! @ChapterInfo Libraries and classes of abstract unitals, Libraries
#! @Arguments 
#! @Description
#!   The function prints the information about the available libraries of
#!   unitals.
DeclareGlobalFunction( "AbstractUnitalLibraryInfo" );
