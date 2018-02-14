#
# UnitalSZ: Algorithms and library of unitals of projective planes
#
# Declarations
#

DeclareCategory( "IsAbstractUnitalDesign", IsObject );
DeclareSynonym( "IsAbstractUnital", IsAbstractUnitalDesign );

DeclareRepresentation( "IsAbstractUnitalDesignRep", IsComponentObjectRep and
                       IsAttributeStoringRep, [ "bmat" ] );
AU_UnitalDesignFamily := NewFamily( "AbstractUnitalDesignFam" );

#! @Arguments bmat
#! @Returns
#!   <K>true</K> if <A>bmat</A> is the blist list of an abstract unital.
#! @Description
#!   Each row of <A>bmat</A> corresponds to a block of the unital. We check the
#!   sizes of the blocks and the sizes of the intersections of the dual blocks.
DeclareGlobalFunction( "AU_UnitalBlistList_axiomcheck" );
#! @Arguments bmat
#! @Returns
#!   <K>true</K> if <A>bmat</A> is the blist list of an abstract unital.
#! @Description
#!   Each row of <A>bmat</A> corresponds to a block of the unital. We check the
#!   sizes of the blocks and the sizes of the intersections of the dual blocks.
#!   Wrong <A>bmat</A> matrix size drops error.
DeclareGlobalFunction( "AU_IsUnitalBlistList" );
#! @Arguments incmat
#! @Returns
#!   <K>true</K> if <A>incmat</A> is the incidence matrix of an abstract unital.
#! @Description
#!   Each row of <A>incmat</A> corresponds to a block of the unital. We check
#!   the sizes of the blocks and the sizes of the intersections of the dual
#!   blocks. Wrong <A>incmat</A> matrix size drops error.
DeclareGlobalFunction( "AU_IsUnitalIncidenceMatrix" );
#! @Arguments blocklist
#! @Returns
#!   <K>true</K> if <A>blocklist</A> is the list of blocks of an abstract
#!   unital.
#! @Description
#!   We check the sizes of the blocks and the sizes of the intersections of the
#!   dual blocks. Wrong number of blocks or wrong number of points (union of the
#!   blocks in <A>blocklist</A>) drops error.
DeclareGlobalFunction( "AU_IsUnitalBlockDesign" );

#! @Arguments bmat
#! @Returns
#!   The unital object corresponding to the blist list <A>bmat</A>.
#! @Description
#!   The function stores <A>bmat</A> and sets the order of the unital. The
#!   function <E>do not check</E> the necessary conditions (the size of bmat,
#!   the sizes of the blocks and their intersections).
DeclareGlobalFunction( "AU_UnitalByBlistListNC" );
#! @Arguments bmat
#! @Returns
#!   The unital object corresponding to the blist list <A>bmat</A>.
#! @Description
#!   Each row of <A>bmat</A> corresponds to a block of the unital. We check the
#!   sizes of the blocks and the sizes of the intersections of the dual blocks.
#!   Wrong <A>bmat</A> matrix size drops error. The function stores <A>bmat</A>
#!   and sets the <C>Order</C> of the unital.
DeclareGlobalFunction( "AbstractUnitalByBlistList" );
#! @Arguments blocklist
#! @Returns
#!   The unital object corresponding to the list of blocks <A>blocklist</A>.
# @Description
#!   We check the sizes of the blocks and the sizes of the intersections of the
#!   dual blocks. Wrong number of blocks or wrong number of points (union of the
#!   blocks in <A>blocklist</A>) drops error. The function stores <C>bmat</C>,
#!   which is based on <A>blocklist</A>, sets the <C>Order</C> of the unital and
#!   sets the names of the points, <C>PointNamesOfUnital</C> of the unital.
DeclareGlobalFunction( "AbstractUnitalByDesignBlocks" );
#! @Arguments incmat
#! @Returns
#!   The unital object corresponding to the incidence matrix <A>incmat</A>.
#! @Description
#!   Each row of <A>incmat</A> corresponds to a block of the unital. We check
#!   the sizes of the blocks and the sizes of the intersections of the dual
#!   blocks. Wrong <A>incmat</A> matrix size drops error. The function stores
#!   <C>bmat</C>, which is based on <A>incmat</A> and sets the <C>Order</C> of
#!   the unital.
DeclareGlobalFunction( "AbstractUnitalByIncidenceMatrix" );


#! @Arguments u
#! @Returns
#!   The range <C>[ 1..q^3 + 1 ]</C>.
#! @Description
#!   If <A>u</A> is a unital of order <M>q</M>, then <A>u</A> has <M>q^3 + 1</M>
#!   points.
DeclareAttribute( "PointsOfUnital", IsAbstractUnitalDesign );
#! @Arguments u
#! @Returns
#!   The blocks of the unital <A>u</A>.
#! @Description
#!   If <A>u</A> is a unital of order <M>q</M>, then each block is a subset of
#!   the points of the unital with <M>q + 1</M> points. The function computes
#!   the blocks with the help of its the boolean incidence matrix <C>bmat</C>
#!   and <C>PointsOfUnital(<A>u</A>)</C>.
DeclareAttribute( "BlocksOfUnital", IsAbstractUnitalDesign );
#! @Arguments u
#! @Returns
#!   The range <C>[ 1..q^3 + 1 ]</C>.
#! @Description
#!   If <A>u</A> is a unital of order <M>q</M> then <A>u</A> has <M>q^3 + 1</M>
#!   points.
DeclareAttribute( "PointNamesOfUnital", IsAbstractUnitalDesign );
#! @Arguments u
#! @Returns
#!   The (bipartite) digraph constructed from the boolean incidence matrix
#!   <C>bmat</C> of the unital <A>u</A>.
DeclareAttribute( "IncidenceDigraph", IsAbstractUnitalDesign );
#! @Arguments u
#! @Returns
#!   The automorphism group of the unital <A>u</A>.
#! @Description
#!   The function computes the automorphism group of <A>u</A> with the help of
#!   its incidence digraph.
DeclareAttribute( "AutomorphismGroup", IsAbstractUnitalDesign );
#! @Arguments u1, u2
#! @Returns
#!   An isomorphism between the unitals <A>u1</A> and <A>u1</A> if they are
#!   isomorphic, and <K>fail</K> otherwise.
#! @Description
#!   The isomorphism is a permutation which sends the points of the unital
#!   <A>u1</A> to the points of the unital <A>u2</A> such that the it preserves
#!   the incidence between the points and the blocks. The function computes the
#!   isomorphism with the help of the incidence digraphs of the unitals
#!   <A>u1</A> and <A>u2</A>.
DeclareOperation( "Isomorphism", [ IsAbstractUnitalDesign, IsAbstractUnitalDesign ] );
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
