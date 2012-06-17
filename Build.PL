
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::Find" => 0,
    "Module::Build" => "0.3601",
    "Test::More" => 0
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Fetch a story from a fiction website",
  "dist_author" => [
    "Kathryn Andersen <perlkat\@katspace.org>"
  ],
  "dist_name" => "WWW-FetchStory",
  "dist_version" => "0.1807",
  "license" => "perl",
  "module_name" => "WWW::FetchStory",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Archive::Zip" => 0,
    "Date::Format" => 0,
    "EBook::EPUB" => 0,
    "Encode" => 0,
    "Encode::ZapCP1252" => 0,
    "File::Basename" => 0,
    "File::Temp" => 0,
    "Getopt::Long" => "2.34",
    "HTML::Entities" => 0,
    "HTML::Strip" => 0,
    "HTML::Tidy::libXML" => 0,
    "HTTP::Cookies" => 0,
    "HTTP::Cookies::Mozilla" => 0,
    "LWP::UserAgent" => 0,
    "Module::Pluggable" => 0,
    "Pod::Usage" => 0,
    "XML::LibXML" => 0,
    "YAML::Any" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => [
    "scripts/fetch_story"
  ]
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
