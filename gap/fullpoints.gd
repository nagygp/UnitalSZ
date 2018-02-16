#! @Arguments u
#! @Returns The list of records <C>r</C> containing the fields <C>r.block1, r.block2, r.fullpts</C>,
#!   where <C>r.fullpts</C> is the set of full point of <A>u</A> w.r.t.
#!   the blocks <C>r.block1, r.block2</C>. The returned list contains all possible full points of <A>u</A>.
#! @Description The point <M>P</M> is a <E>full point</E> of the unital <M>U</M> w.r.t. the blocks
#!   <M>b_1,b_2</M> if <M>P</M> is not contained in <M>b_1</M> or <M>b_2</M>, and,
#!   the projection with center <M>P</M> from <M>b_1</M> to <M>b_2</M> is a
#!   well-defined bijection.
DeclareAttribute( "FullPointsOfUnital", IsAbstractUnitalDesign );
#! @Arguments u
#! @Returns A list of records of full points of <A>u</A> up to the automorphism group of <A>u</A>.
#!   In other words, if <M>P</M> is a full point w.r.t. the blocks <M>b_1,b_2</M>, then there is an
#!   automorphism <M>\alpha</M> of <M>U</M> such that <M>P^\alpha, b_1^\alpha, b_2^\alpha</M> are 
#!   in the list. 
DeclareAttribute( "FullPointsOfUnitalRepresentatives", IsAbstractUnitalDesign );
#! @Arguments u
#! @Returns The list of records <C>r</C> containing the fields <C>r.block1, r.block2, r.fullpts, 
#!   r.gens</C>, where <C>r.fullpts</C> is the set of full point of <A>u</A> w.r.t.
#!   the blocks <C>r.block1, r.block2</C>. The field <C>r.gens</C> contains the permutations 
#!   defined by the projections from one block to the other with center of the full points.
#! @Description The permutations in <C>r.gens</C> are constructed the
#!   following way: first we project <M>b_1</M> to <M>b_2</M> with center
#!   <M>P</M>, where <M>P</M> is the first element of the list of full points.
#!   Then we take all projections from <M>b_2</M> to
#!   <M>b_1</M> with center <M>Q</M>, where <M>Q</M> ranges through
#!   the list of full points. All these projections define a permutation on
#!   <M>b_1</M>, since the projections were well-defined bijections.
DeclareAttribute( "GeneratorsOfProjectivityGroupsOfUnital", IsAbstractUnitalDesign );
