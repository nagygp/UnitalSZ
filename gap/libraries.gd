#
# Abstract unital libraries by Betten-Betten-Tonchev (order 3) and Krcadinac-Nakic-Pavcevic
# (order 4)
#
# Declarations
#

#! @ChapterInfo Libraries and classes of abstract unitals, Global functions for internal usage
#! @Arguments data
#! @Returns
#!  The list of boolean incidence matrices of size $(q^3 + 1) \times q^2(q^2 -
#!  q + 1)$ read from <A>filename</A>.
#! @Description
#!  The argument <A>data</A> must be a record with fields <C>filename, order, nr</C>. 
#!  The file <A>data.filename</A> must be gzipped and must contain <A>data.nr</A>
#!  matrices of dimension mentioned above. The matrices must be 0-1 matrices
#!  without any whitespace between the entries in one row and there must not be
#!  any empty lines between matrices.
DeclareGlobalFunction( "ReadLibraryDataFromFiles@" );

#! @ChapterInfo Libraries and classes of abstract unitals, Global functions for internal usage
#! @Arguments name, n
#! @Returns
#!  The <A>n</A>th abstract unital from the library <A>name</A>. Non-checking version.
DeclareGlobalFunction( "ReadAbstractUnitalFromLibraryNC@" );

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
#!   The <A>n</A>th (abstract) unital of order 3, constructed by paramodification from
#!   the BBT and Krcadinac libraries.
#! @Description
#!   [...]
DeclareGlobalFunction( "P3MAbstractUnital" );

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
#! @Arguments n
#! @Returns
#!   The <A>n</A>th (abstract) $SL(2,8)$-invariant unital of order 8, constructed 
#!   by the Grundhöfer-Stroppel-Van Maldeghem method. 
#! @Description
#!   These unitals may have many translation centers.
DeclareGlobalFunction( "SL28InvariantAbstractUnital" );

#! @ChapterInfo Libraries and classes of abstract unitals, Libraries
#! @Arguments 
#! @Description
#!   The function prints the information about the available libraries of
#!   unitals.
DeclareGlobalFunction( "AbstractUnitalLibraryInfo" );

#! @ChapterInfo Libraries and classes of abstract unitals, Libraries
#! @Arguments name
#! @Returns
#!   The number of abstract unitals in the library <A>name</A>. 
DeclareGlobalFunction( "NumberOfAbstractUnitalsInLibrary" );