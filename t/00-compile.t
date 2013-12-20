use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Compile 2.037

use Test::More  tests => 24 + ($ENV{AUTHOR_TESTING} ? 1 : 0);



my @module_files = (
    'HTTP/Cookies/Wget.pm',
    'WWW/FetchStory.pm',
    'WWW/FetchStory/Fetcher.pm',
    'WWW/FetchStory/Fetcher/AO3.pm',
    'WWW/FetchStory/Fetcher/Ashwinder.pm',
    'WWW/FetchStory/Fetcher/Default.pm',
    'WWW/FetchStory/Fetcher/DigitalQuill.pm',
    'WWW/FetchStory/Fetcher/DracoAndGinny.pm',
    'WWW/FetchStory/Fetcher/Dreamwidth.pm',
    'WWW/FetchStory/Fetcher/FanfictionNet.pm',
    'WWW/FetchStory/Fetcher/FictionAlley.pm',
    'WWW/FetchStory/Fetcher/Gutenberg.pm',
    'WWW/FetchStory/Fetcher/HPAdultFanfiction.pm',
    'WWW/FetchStory/Fetcher/LiveJournal.pm',
    'WWW/FetchStory/Fetcher/Owl.pm',
    'WWW/FetchStory/Fetcher/PetulantPoetess.pm',
    'WWW/FetchStory/Fetcher/PotionsAndSnitches.pm',
    'WWW/FetchStory/Fetcher/PotterPlace.pm',
    'WWW/FetchStory/Fetcher/RestrictedSection.pm',
    'WWW/FetchStory/Fetcher/SSHGExchange.pm',
    'WWW/FetchStory/Fetcher/TardisBigBang3.pm',
    'WWW/FetchStory/Fetcher/Teaspoon.pm',
    'WWW/FetchStory/Fetcher/TwistingHellmouth.pm'
);

my @scripts = (
    'scripts/fetch_story'
);

# no fake home requested

my $inc_switch = -d 'blib' ? '-Mblib' : '-Ilib';

use File::Spec;
use IPC::Open3;
use IO::Handle;

my @warnings;
for my $lib (@module_files)
{
    # see L<perlfaq8/How can I capture STDERR from an external command?>
    open my $stdin, '<', File::Spec->devnull or die "can't open devnull: $!";
    my $stderr = IO::Handle->new;

    my $pid = open3($stdin, '>&STDERR', $stderr, $^X, $inc_switch, '-e', "require q[$lib]");
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid($pid, 0);
    is($?, 0, "$lib loaded ok");

    if (@_warnings)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
}

foreach my $file (@scripts)
{ SKIP: {
    open my $fh, '<', $file or warn("Unable to open $file: $!"), next;
    my $line = <$fh>;
    close $fh and skip("$file isn't perl", 1) unless $line =~ /^#!.*?\bperl\b\s*(.*)$/;

    my @flags = $1 ? split(/\s+/, $1) : ();

    open my $stdin, '<', File::Spec->devnull or die "can't open devnull: $!";
    my $stderr = IO::Handle->new;

    my $pid = open3($stdin, '>&STDERR', $stderr, $^X, $inc_switch, @flags, '-c', $file);
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid($pid, 0);
    is($?, 0, "$file compiled ok");

   # in older perls, -c output is simply the file portion of the path being tested
    if (@_warnings = grep { !/\bsyntax OK$/ }
        grep { chomp; $_ ne (File::Spec->splitpath($file))[2] } @_warnings)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
} }



is(scalar(@warnings), 0, 'no warnings found') if $ENV{AUTHOR_TESTING};


