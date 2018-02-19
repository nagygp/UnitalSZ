#
# Constructions of different classes of abstract unitals
#
# Declarations
#

#! @ChapterInfo Libraries and classes of abstract unitals, Classes of abstract
#!  unitals
#! @Arguments q
#! @Returns
#!   The classical unital object, which is the abstract unital of order <A>q</A>
#!   isomorphic to the Hermitian curve in the classical projective plane.
#! @Description
#!   The Hermitian curve has the following canonical equation: <M>X_0^{q + 1} +
#!   X_1^{q + 1} + X_2^{q + 1} = 0</M>. The function computes the blocks of the
#!   unital with the help of <C>PGU(3,<A>q</A>)</C> and calls
#!   <C>AbstractUnitalByDesignBlocks</C>. The <C>Name</C> of the unital is set
#!   as <C>HermitianAbstractUnital(<A>q</A>)</C>.
DeclareGlobalFunction( "HermitianAbstractUnital" );
#! @Arguments q
#! @Returns
#!  All the pairs of <M>GF(q^2)</M> which are possible parameters of a(n
#!  orthogonal) Buekenhout-Metz unital of order <A>q</A>.
#! @Description
#!  If <A>q</A> is an odd prime power and <M>(\alpha, \beta)</M> is 2-tuple of
#!  <M>GF(q^2)</M>, then this pair is a suitable parameter of an orthogonal
#!  Buekenhout-Metz unital, if <M>(\beta^q - \beta)^2 + 4 \alpha^{q + 1}</M> is
#!  a nonsquare in <M>GF(q)</M>.
#!
#!  If <A>q</A> is an even prime power and <M>(\alpha, \beta)</M> is 2-tuple of
#!  <M>GF(q^2)</M>, then this pair is a suitable parameter of an orthogonal
#!  Buekenhout-Metz unital, if <M>\beta \not\in GF(q)</M> and <M>\alpha^{q +
#!  1}(\beta^q + \beta)^2</M> has absolute trace 0.
#!
#!  In both cases $\alpha = 0$ yields the Hermitian classical unital, hence we
#!  we omit the tuples with <M>\alpha = 0</M>.
DeclareGlobalFunction( "AllBuekenhoutMetzAbstractUnitalParameters" );
