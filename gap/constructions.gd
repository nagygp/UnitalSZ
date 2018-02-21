#
# Constructions of different classes of abstract unitals
#
# Declarations
#

#! @Chapter Libraries and classes of abstract unitals
#! @Section Classes of abstract unitals
#! @Section Libraries
#! @Section Global functions for internal usage

#! @ChapterInfo Libraries and classes of abstract unitals, Classes of abstract unitals
#! @Arguments q
#! @Returns
#!   The classical unital object, which is the abstract unital of order <A>q</A>
#!   isomorphic to the Hermitian curve in the classical projective plane.
#! @Description
#!   The Hermitian curve has the following canonical equation: $X_0^{q + 1} +
#!   X_1^{q + 1} + X_2^{q + 1} = 0$. The function computes the blocks of the
#!   unital with the help of <C>PGU(3,<A>q</A>)</C> and calls
#!   <C>AbstractUnitalByDesignBlocks</C>. The <C>Name</C> of the unital is set
#!   as <C>HermitianAbstractUnital(<A>q</A>)</C>.
DeclareGlobalFunction( "HermitianAbstractUnital" );

#! @ChapterInfo Libraries and classes of abstract unitals, Classes of abstract unitals
#! @Arguments q
#! @Returns
#!  All the pairs over $GF(q^2)$ which are possible parameters of a(n
#!  orthogonal) Buekenhout-Metz unital of order <A>q</A>.
#! @Description
#!  The argument <A>q</A> must be a prime power (if even, then at least 4).
#!
#!  If <A>q</A> is an odd prime power and $(\alpha, \beta)$ is 2-tuple of
#!  $GF(q^2)$, then this pair is a suitable parameter of an orthogonal
#!  Buekenhout-Metz unital, if $(\beta^q - \beta)^2 + 4 \alpha^{q + 1}$ is
#!  a nonsquare in $GF(q)$.
#!
#!  If <A>q</A> is an even prime power and $(\alpha, \beta)$ is 2-tuple of
#!  $GF(q^2)$, then this pair is a suitable parameter of an orthogonal
#!  Buekenhout-Metz unital, if $\beta \not\in GF(q)$ and $\alpha^{q +
#!  1}(\beta^q + \beta)^2$ has absolute trace 0.
#!
#!  In both cases $\alpha = 0$ yields the Hermitian classical unital, hence we
#!  omit the tuples with $\alpha = 0$.
DeclareGlobalFunction( "AllBuekenhoutMetzAbstractUnitalParameters" );

#! @ChapterInfo Libraries and classes of abstract unitals, Classes of abstract unitals
#! @Arguments q, alpha, beta
#! @Returns
#!  The unital object, which is the abstract unital of order <A>q</A>
#!  isomorphic to the orthogonal Buekenhout-Metz unital with parameters
#!  <A>alpha</A> and <A>beta</A> in the classical projective plane.
#! @Description
#!  The argument <A>q</A> must be a prime power (if even, then at least 4), the
#!  other arguments <A>alpha</A> and <A>beta</A> - elements of $GF(q^2)$ -
#!  must be a pair from
#!  <C>AllBuekenhoutMetzAbstractUnitalParameters(</C><A>q</A><C>)</C>.
#!
#!  The point set $U_{\alpha, \beta} = \left\{ ( x, \alpha x^2 + \beta x^{q +
#!  1} + r, 1) \colon x \in GF(q^2), r \in GF(q) \right\} \cup
#!  \left\{ (0, 1, 0) \right\}$ in $PG(2,q^2)$ is a unital (called the
#!  orthogonal Buekenhout-Metz unital) if the pair of parameters $(\alpha,
#!  \beta)$ satisfies the conditions explained in the description of
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
#!  The point set $U_T = \left\{ ( x_0 + x_1 \delta, y_0 + (x_0^{\tau + 2} +
#!  x_1^\tau + x_0x_1)\delta, 1) \colon x_0, x_1, y_0 \in GF(q)\right\} \cup
#!  \left\{ (0,1,0) \right\}$ in $PG(2,q^2)$ is a unital (called the
#!  Buekenhout-Tits unital) if $\delta \in GF(q^2) \setminus GF(4)$ and
#!  $\delta^q = 1 + \delta$. This $\delta$ is just a basis element
#!  along with 1 in $GF(q^2)$ over $GF(q)$, hence we can omit it as a
#!  parameter. The function $\tau \colon GF(q) \rightarrow GF(q)$ assigns
#!  to the field element $x$ the following: $x \mapsto x^{2^\frac{k +
#!  1}{2}}$, where $q = 2^k$.
DeclareGlobalFunction( "BuekenhoutTitsAbstractUnital" );
