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
#!   <C>AbstractUnitalByDesignBlocks</C>. The <C>Name</C> of the unital is set
#!   as <C>HermitianAbstractUnital(<A>q</A>)</C>.
DeclareGlobalFunction( "HermitianAbstractUnital" );
#! @ChapterInfo Libraries and classes of abstract unitals, Classes of abstract unitals
#! @Arguments q
#! @Returns
#!  All the pairs over <M>GF(q^2)</M> which are possible parameters of a(n
#!  orthogonal) Buekenhout-Metz unital of order <A>q</A>.
#! @Description
#!  The argument <A>q</A> must be a prime power (if even, then at least 4).
#!
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
#!  omit the tuples with <M>\alpha = 0</M>.
DeclareGlobalFunction( "AllBuekenhoutMetzAbstractUnitalParameters" );
#! @ChapterInfo Libraries and classes of abstract unitals, Classes of abstract unitals
#! @Arguments q, alpha, beta
#! @Returns
#!  The unital object, which is the abstract unital of order <A>q</A>
#!  isomorphic to the orthogonal Buekenhout-Metz unital with parameters
#!  <A>alpha</A> and <A>beta</A> in the classical projective plane.
#! @Description
#!  The argument <A>q</A> must be a prime power (if even, then at least 4), the
#!  other arguments <A>alpha</A> and <A>beta</A> - elements of <M>GF(q^2)</M> -
#!  must be a pair from
#!  <C>AllBuekenhoutMetzAbstractUnitalParameters(</C><A>q</A><C>)</C>.
#!
#!  The point set <M>U_{\alpha, \beta} = \left\{ ( x, \alpha x^2 + \beta x^{q +
#!  1} + r, 1) \colon x \in GF(q^2), r \in GF(q) \right\} \cup
#!  \left\{ (0, 1, 0) \right\}</M> in <M>PG(2,q^2)</M> is a unital (called the
#!  orthogonal Buekenhout-Metz unital) if the pair of parameters <M>(\alpha,
#!  \beta)</M> satisfies the conditions explained in the description of
#!  <C>AllBuekenhoutMetzAbstractUnitalParameters(</C><A>q</A><C>)</C>.
DeclareGlobalFunction( "OrthogonalBuekenhoutMetzAbstractUnital" );
#! @ChapterInfo Libraries and classes of abstract unitals, Classes of abstract unitals
#! @Arguments q
#! @Returns
#!  The unital object, which is the abstract unital of order <A>q</A>
#!  isomorphic to the Buekenhout-Tits unital in the classical projective plane.
#! @Description
#!  The argument <A>q</A> must be a power of 2, such that the exponent is an
#!  odd integer at least 3.
#!  The point set <M>U_T = \left\{ ( x_0 + x_1 \delta, y_0 + (x_0^{\tau + 2} +
#!  x_1^\tau + x_0x_1)\delta, 1) \colon x_0, x_1, y_0 \in GF(q)\right\} \cup
#!  \left\{ (0,1,0) \right\}</M> in <M>PG(2,q^2)</M> is a unital (called the
#!  Buekenhout-Tits unital) if <M>\delta \in GF(q^2) \setminus GF(4)</M> and
#!  <M>\delta^q = 1 + \delta</M>. This <M>\delta</M> is just a basis element
#!  along with 1 in <M>GF(q^2)</M> over <M>GF(q)</M>, hence we can omit it as a
#!  parameter. The function <M>\tau \colon GF(q) \rightarrow GF(q)</M> assigns
#!  to the field element <M>x</M> the following: <M>x \mapsto x^{2^\frac{k +
#!  1}{2}}</M>, where <M>q = 2^k</M>.
DeclareGlobalFunction( "BuekenhoutTitsAbstractUnital" );
