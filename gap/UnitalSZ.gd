#
# UnitalSZ: Algorithms and library of unitals of projective planes
#
# Declarations
#

DeclareCategory( "IsAU_UnitalDesign", IsObject );
DeclareSynonym( "IsAU_Unital", IsAU_UnitalDesign );
DeclareSynonym( "IsAU_AbstractUnital", IsAU_UnitalDesign );

DeclareRepresentation( "IsAU_UnitalDesignRep", IsComponentObjectRep and
                       IsAttributeStoringRep, [ "bmat" ] );
AU_UnitalDesignFamily := NewFamily( "AbstractUnitalDesignFam" );


#! @Description
#!   Insert documentation for you function here
DeclareGlobalFunction( "AU_UnitalBlistList_axiomcheck" );
#! @Arguments bmat
#! @Returns true if <A>bmat</A> is the blist list of an abstract unital.
#! @Description
#!   Each row of <A>bmat</A> corresponds to a block of the unital. We check the
#!   sizes of the blocks and the sizes of the intersections of the dual blocks.
#!   Wrong <A>bmat</A> matrix size drops error.
DeclareGlobalFunction( "IsAU_UnitalBlistList" );
#! @Description
#!   Insert documentation for you function here
DeclareGlobalFunction( "IsAU_UnitalIncidenceMatrix" );
#! @Description
#!   Insert documentation for you function here
DeclareGlobalFunction( "IsAU_UnitalBlockDesign" );

#! @Description
#!   Insert documentation for you function here
DeclareGlobalFunction( "AU_UnitalByBlistListNC" );
#! @Description
#!   Insert documentation for you function here
DeclareGlobalFunction( "AU_UnitalByBlistList" );
#! @Description
#!   Insert documentation for you function here
DeclareGlobalFunction( "AU_UnitalByDesignBlocks" );
#! @Description
#!   Insert documentation for you function here
DeclareGlobalFunction( "AU_UnitalByIncidenceMatrix" );


#! @Description
#!   Insert documentation for you function here
DeclareAttribute( "Points", IsAU_UnitalDesign );
#! @Description
#!   Insert documentation for you function here
DeclareAttribute( "Blocks", IsAU_UnitalDesign );
#! @Description
#!   Insert documentation for you function here
DeclareAttribute( "IncidenceDigraph", IsAU_UnitalDesign );
#! @Description
#!   Insert documentation for you function here
DeclareAttribute( "AU_FullPointsNumberRepresentation", IsAU_UnitalDesign );
#! @Description
#!   Insert documentation for you function here
DeclareAttribute( "AutomorphismGroup", IsAU_UnitalDesign );
#! @Description
#!   Insert documentation for you function here
DeclareOperation( "Isomorphism", [ IsAU_UnitalDesign, IsAU_UnitalDesign ] );
#! @Description
#!   Insert documentation for you function here
DeclareAttribute( "AU_FullPointsGenerators", IsAU_UnitalDesign );
#! @Description
#!   Insert documentation for you function here
DeclareGlobalFunction( "AU_HermitianAbstractUnital" );
