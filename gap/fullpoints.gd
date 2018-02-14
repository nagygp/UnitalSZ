#! @Arguments u
#! @Returns The list of records containing the triples <C>(b1, b2, list)</C>,
#! where any member of the list <C>list</C> is a full point of <A>u</A> w.r.t.
#! the blocks <C>b1, b2</C>.
#! @Description The point <M>P</M> is a full point of <A>u</A> w.r.t. the blocks
#!   <C>b1,b2</C> if <M>P</M> is not contained in <C>b1</C> or <C>b2</C>, and,
#!   the projection with center <M>P</M> from <C>b1</C> to <C>b2</C> is a
#!   well-defined bijection.
DeclareAttribute( "FullPointsOfUnital", IsAbstractUnitalDesign );
#! @Arguments u
#! @Returns The list of records containing the triples <C>(ind_b1, ind_b2,
#!   ind_list)</C>, where any member of the list <C>ind_list</C> is an index of a full
#!   point of <A>u</A> w.r.t. the blocks corresponding to <C>ind_b1, ind_b2</C>.
#! @Description The point corresponding to the index <C>P</C> is a full point of
#!   <A>u</A> w.r.t. the blocks corresponding to the indices <C>ind_b1,
#!   ind_b2</C> if <C>P</C> is not contained in <C>ind_b1</C> or <C>ind_b2</C>,
#!   and, the projection with center <C>P</C> from <C>ind_b1</C> to
#!   <C>ind_b2</C> is a well-defined bijection.
DeclareAttribute( "FullPointsOfUnitalRepresentatives", IsAbstractUnitalDesign );
#! @Arguments u
#! @Returns The list of records containing the quadruples <C>(ind_b1, ind_b2,
#!   ind_list, perm_list)</C>, where any member of the list <C>ind_list</C> is
#!   an index of a full point of <A>u</A> w.r.t. the blocks corresponding to
#!   <C>ind_b1, ind_b2</C> and <C>perm_list</C> contains permutations of the
#!   block <C>ind_b1</C> defined by projections between <C>ind_b1</C> and
#!   <C>ind_b2</C> with centers from the list of full points <C>ind_list</C>.
#! @Description The permutations in <C>perm_list</C> are constructed the
#!   following way: first we project <C>ind_b1</C> to <C>ind_b2</C> with center
#!   <C>P</C>, where <C>P</C> is the first element of the list of full points
#!   <C>ind_list</C>, then we take all projections from <C>ind_b2</C> to
#!   <C>ind_b1</C> with center <C>Q</C>, where <C>Q</C> ranges through
#!   <C>ind_list</C>. Cll these projections define a permutation on
#!   <C>ind_b1</C>, since the projections were well-defined bijections.
DeclareAttribute( "GeneratorsOfProjectivityGroupsOfUnital", IsAbstractUnitalDesign );
