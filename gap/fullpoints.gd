#! @Arguments U
#! @Returns The list of records containing the triples <M>(b_1,b_2,P)</M>,
#!   where <M>P</M> is a full point of <A>U</A> w.r.t. the blocks <M>b_1,b_2</M>.
#! @Description
#!   The point <M>P</M> is a full point of <A>U</A> w.r.t. the blocks <M>b_1,b_2</M>
#!   if <M>P</M> is not contained in <M>b_1</M> or <M>b_2</M>, and, the projection
#!   with center <M>P</M> from <M>b_1</M> to <M>b_2</M> is a well-defined bijection.
DeclareAttribute( "FullPointsOfUnital", IsAU_UnitalDesign );
#! @Description
#!   Insert documentation for you function here
DeclareAttribute( "FullPointsOfUnitalRepresentatives", IsAU_UnitalDesign );
#! @Description
#!   Insert documentation for you function here
DeclareAttribute( "GeneratorsOfProjectivityGroupsOfUnital", IsAU_UnitalDesign );
