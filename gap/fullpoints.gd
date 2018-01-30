#! @Arguments U
#! @Returns The list of records containing the triples <A>(b1, b2, list)</A>,
#! where any member of the list <A>list</A> is a full point of <A>U</A> w.r.t.
#! the blocks <A>b1, b2</A>.
#! @Description The point <M>P</M> is a full point of <A>U</A> w.r.t. the blocks
#!   <A>b1,b2</A> if <M>P</M> is not contained in <A>b1</A> or <A>b2</A>, and,
#!   the projection with center <M>P</M> from <A>b1</A> to <A>b2</A> is a
#!   well-defined bijection.
DeclareAttribute( "FullPointsOfUnital", IsAU_UnitalDesign );
#! @Arguments U
#! @Returns The list of records containing the triples <A>(ind_b1, ind_b2,
#!   ind_list)</A>, where any member of the list <A>ind_list</A> is an index of a full
#!   point of <A>U</A> w.r.t. the blocks corresponding to <A>ind_b1, ind_b2</A>.
#! @Description The point corresponding to the index <A>P</A> is a full point of
#!   <A>U</A> w.r.t. the blocks corresponding to the indices <A>ind_b1,
#!   ind_b2</A> if <A>P</A> is not contained in <A>ind_b1</A> or <A>ind_b2</A>,
#!   and, the projection with center <A>P</A> from <A>ind_b1</A> to
#!   <A>ind_b2</A> is a well-defined bijection.
DeclareAttribute( "FullPointsOfUnitalRepresentatives", IsAU_UnitalDesign );
#! @Arguments U
#! @Returns The list of records containing the quadruples <A>(ind_b1, ind_b2,
#!   ind_list, perm_list)</A>, where any member of the list <A>ind_list</A> is
#!   an index of a full point of <A>U</A> w.r.t. the blocks corresponding to
#!   <A>ind_b1, ind_b2</A> and <A>perm_list</A> contains permutations of the
#!   block <A>ind_b1</A> defined by projections between <A>ind_b1</A> and
#!   <A>ind_b2</A> with centers from the list of full points <A>ind_list</A>.
#! @Description The permutations in <A>perm_list</A> are constructed the
#!   following way: first we project <A>ind_b1</A> to <A>ind_b2</A> with center
#!   <A>P</A>, where <A>P</A> is the first element of the list of full points
#!   <A>ind_list</A>, then we take all projections from <A>ind_b2</A> to
#!   <A>ind_b1</A> with center <A>Q</A>, where <A>Q</A> ranges through
#!   <A>ind_list</A>. All these projections define a permutation on
#!   <A>ind_b1</A>, since the projections were well-defined bijections.
DeclareAttribute( "GeneratorsOfProjectivityGroupsOfUnital", IsAU_UnitalDesign );
