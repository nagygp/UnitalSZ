#
# UnitalSZ: Algorithms and library of unitals of projective planes
#
# This file contains package meta data. For additional information on the
# meaning and correct usage of these fields, please consult the manual of the
# "Example" package as well as the comments in its PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "UnitalSZ",
Subtitle := "Algorithms and libraries of abstract unitals and their embeddings",
Version := "0.5",
Date := "23/03/2018", # dd/mm/yyyy format

Persons := [
    rec(
        IsAuthor := true,
        IsMaintainer := true,
        FirstNames := "Gábor Péter",
        LastName := "Nagy",
        WWWHome := "http://www.math.u-szeged.hu/~nagyg",
        Email := "nagyg@math.u-szeged.hu",
        PostalAddress := "H-6720 Szeged, Aradi vértanúk tere 1",
        Place := "Szeged (Hungary)",
        Institution := "University of Szeged",
    ),
    rec(
        IsAuthor := true,
        IsMaintainer := true,
        FirstNames := "Dávid",
        LastName := "Mezőfi",
        WWWHome := "http://www.math.u-szeged.hu/~mezofi",
        Email := "mezofi@math.u-szeged.hu",
        PostalAddress := "H-6720 Szeged, Aradi vértanúk tere 1",
        Place := "Szeged (Hungary)",
        Institution := "University of Szeged",
    ),
],

SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/nagygp/", ~.PackageName ),
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
#SupportEmail   := "TODO",
PackageWWWHome  := "https://nagygp.github.io/UnitalSZ/",
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                  "/releases/download/v", ~.Version,
                                  "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  Concatenation( 
    "<p>This is a GAP package containing ",
    "methods for abstract unitals as block designs.</p> ",
    "<p>There are methods for automorphisms and isomorphisms ",
    "and for the embeddings of unitals in the finite Desarguesian ",
    "projective plane. There are functions for constructing unitals ",
    "and some libraries of unitals os small order.</p>" ),

PackageDoc := rec(
    BookName  := "UnitalSZ",
    ArchiveURLSubset := [ "doc" ],
    HTMLStart := "doc/chap0.html",
    PDFFile   := "doc/manual.pdf",
    SixFile   := "doc/manual.six",
    LongTitle := "Algorithms and libraries of abstract unitals and their embeddings",
),

Dependencies := rec(
    GAP := ">= 4.10.1",
    NeededOtherPackages := [
        [ "GAPDoc", ">= 1.6" ],
        [ "Digraphs", ">= 0.15.0" ],
        [ "io", ">=4.5.4" ]
    ],
    SuggestedOtherPackages := [
        [ "Digraphs", ">= 0.15.1" ]
    ],
    ExternalConditions := [ ],
),

AvailabilityTest := function()
                        return true;
                    end,

TestFile := "tst/testall.g",

Keywords := [ "unital", "abstract unital", "projective embedding", "unital design" ],

));
