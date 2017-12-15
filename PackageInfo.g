#
# UnitalSZ: Algorithms and library of unitals of projective planes
#
# This file contains package meta data. For additional information on the
# meaning and correct usage of these fields, please consult the manual of the
# "Example" package as well as the comments in its PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "UnitalSZ",
Subtitle := "Algorithms and library of unitals of projective planes",
Version := "0.2",
Date := "8/11/2017", # dd/mm/yyyy format

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
        WWWHome := "TODO",
        Email := "david.mezofi93@gmail.com",
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

AbstractHTML   :=  "",

PackageDoc := rec(
    BookName  := "UnitalSZ",
    ArchiveURLSubset := [ "doc" ],
    HTMLStart := "doc/chap0.html",
    PDFFile   := "doc/manual.pdf",
    SixFile   := "doc/manual.six",
    LongTitle := "Algorithms and library of unitals of projective planes",
),

Dependencies := rec(
    GAP := ">= 4.8",
    NeededOtherPackages := [
        [ "GAPDoc", ">= 1.5" ],
        [ "Digraphs", ">= 0.10.1" ],
        [ "io", ">=4.4.6" ]
    ],
    SuggestedOtherPackages := [ ],
    ExternalConditions := [ ],
),

AvailabilityTest := function()
                        return true;
                    end,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));
