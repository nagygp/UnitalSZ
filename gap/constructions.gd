#
# Constructions of different classes of abstract unitals
#
# Declarations
#

#! @ChapterInfo Libraries and classes of abstract unitals, Classes of abstract unitals
#! @Arguments q
#! @Returns
#!   The classical unital object, which is the abstract unital of order <A>q</A>
#!   isomorphic to the Hermitian curve in the classical projective plane.
#! @Description
#!   The Hermitian curve has the following canonical equation: <M>X_0^{q + 1} +
#!   X_1^{q + 1} + X_2^{q + 1} = 0</M>. The function computes the blocks of the
#!   unital with the help of <C>PGU(3,<A>q</A>)</C> and calls
#!   <C>AbstractUnitalByDesignBlocks</C>. The <C>Name</C> of the unital is set as
#!   <C>HermitianAbstractUnital(<A>q</A>)</C>.
DeclareGlobalFunction( "HermitianAbstractUnital" );
