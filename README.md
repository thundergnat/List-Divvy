NAME List::Divvy
================

[![test](https://github.com/thundergnat/List-Divvy/actions/workflows/test.yml/badge.svg)](https://github.com/thundergnat/List-Divvy/actions/workflows/test.yml)

Various shortcut keyword routines to divide up monotonic Positional objects based on values.

SYNOPSIS
========

    use List::Divvy;

    my $list = 1..∞ # an infinite range

    # show the values in the list before a value greater than or equal to 5
    put list.&before(5); # 1 2 3 4

    # show the values in the list up to and including a value equal to 5
    put list.&upto(5); # 1 2 3 4 5

    # show the first 5 values in the list greater than 5
    put $list.&after(5).head(5); # 6 7 8 9 10

    # show the first 5 values in the list greater than or equal to 5
    put $list.&from(5).head(5); # 5 6 7 8 9

    # show the values between 10 and 15
    put $list.&between(10, 15); # 11 12 13 14

    # show the values bounded by 10 and 15
    put $list.&bounded(10, 15); # 10 11 12 13 14 15

DESCRIPTION
===========

Convenience routines to "divvy" up a positional object based on the elements values.

When presenting a portion of an array or list, it is simple in Raku to return a specific number of elements `@array[^5]` or some such. Often you need to find the elements whose **value** is in some range. "Show the elements less than 100" or "find the elements between 25 and 50". There are no built-in routines in Raku for that. It is possible to do but often a little convoluted.

This module exposes several routines to easily partition positionals. These routines are perfectly capable of working with infinite lists and will **not** attempt to reify the whole list to return the requested values.

**Note:** there is at least one other Raku module available ([List::MoreUtils](https://modules.raku.org/dist/List::MoreUtils:zef:zef:lizmat)) that provides similar list partition functionality. [List::MoreUtils](https://modules.raku.org/dist/List::MoreUtils:zef:zef:lizmat) is a Perl 5 port though, and the routines from there are formatted `routine($threshold, @list)` rather than `routine(@list, $threshold)`, which makes it much more difficult to do routine chaining. In this module, the list out from any routine is suitable as the first input parameter to any other routine.

These routines primarily are geared to monotonically increasing numeric values. They can be used with decreasing or variable lists but may not return the results expected.

They will all accept both Real defined numeric values for thresholds, or, Callable blocks or Whatever codes.

Exports the Subs:

  * [before( )](#before)

  * [after( )](#after)

  * [upto( )](#upto)

  * [from( )](#from)

  * [between( )](#between)

  * [bounded( )](#bounded)

Use `before()` and `after()` to partition out value less than or greater than some threshold **not** including the threshold value.

<a name="before"></a>before( )
------------------------------

Returns the list of values `before()` the given defined value or Whatevercode.

### before( Real $value ); or before( Callable $block );

  * $value

    * value; any Real number (Rat, Int, or Num)

  * $block

    * callable; an expression, block or Whatevercode that returns a Boolean

Pass in a defined Real value to get all of the elements up to but not including that value. `(1..100).&before(10)` to get:

    1 2 3 4 5 6 7 8 9

Or a Whatevercode `(1..100).&before(* %% 7)` returns:

    1 2 3 4 5 6

<a name="after"></a>after( )
----------------------------

Complement to `before()`, `after()` returns the elements greater than the passed in value or code block.

### after( Real $value ); or after( Callable $block );

  * $value

    * value; any Real number (Rat, Int, or Num)

  * $block

    * callable; an expression, block or Whatevercode that returns a Boolean

Pass in a defined Real value to get all of the elements after but not including that value. `(1..10).&after(5)` to get:

    6 7 8 9 10

Or a Whatevercode `(1..10).&after(* %% 7)` returns:

    8 9 10

Use `upto()` and `from()` to partition out value less than or greater than some threshold including the threshold value.

<a name="upto"></a>upto( )
--------------------------

Returns the list of values `upto()` the given defined value or Whatevercode.

### upto( Real $value ); or upto( Callable $block );

  * $value

    * value; any Real number (Rat, Int, or Num)

  * $block

    * callable; an expression, block or Whatevercode that returns a Boolean

Pass in a defined Real value to get all of the elements up to and including that value. `(1..100).&upto(10)` to get:

    1 2 3 4 5 6 7 8 9 10

Or a Whatevercode `(1..100).&upto(* %% 7)` returns:

    1 2 3 4 5 6 7

<a name="from"></a>from( )
--------------------------

Complement to `upto()`, `from()` returns the elements greater than or equal to the passed in value or code block.

### from( Real $value ); or from( Callable $block );

  * $value

    * value; any Real number (Rat, Int, or Num)

  * $block

    * callable; an expression, block or Whatevercode that returns a Boolean

Pass in a defined Real value to get all of the elements greater than or equal to that value. `(1..10).&from(5)` to get:

    5 6 7 8 9 10

Or a Whatevercode `(1..10).from(* %% 7)` returns:

    7 8 9 10

Similar to the single ended partition routines, there are routines `between` and `bounded`.

<a name="between"></a>between( )
--------------------------------

Returns the list of values `between()` the two boundary values.

### between( Real (or Callable) $lo, Real (or Callable) $hi );

  * $lo

    * value; lower threshold, any Real number (Rat, Int, or Num) or Callable

  * $hi

    * value; upper threshold, any Real number (Rat, Int, or Num) or Callable

Gets all of the elements between but not including the threshold values.

`(1..100).&between(23, 29)` to get:

    24 25 26 27 28

<a name="bounded"></a>bounded( )
--------------------------------

Returns the list of values `bounded()` by the two threshold values.

### bounded( Real (or Callable) $lo, Real (or Callable) $hi );

  * $lo

    * value; lower threshold, any Real number (Rat, Int, or Num) or Callable

  * $hi

    * value; upper threshold, any Real number (Rat, Int, or Num) or Callable

Get all of the elements bounded by, and including the threshold values.

`(1..100).&between(23, 29)` to get:

    23 24 25 26 27 28 29

You may also combine and chain the single ended partitions in various combinations to include or exclude the upper and lower thresholds as desired.

`(1..20).&after(4).&upto(12)` to get:

    5 6 7 8 9 10 11 12

Note that these examples have all used integers, but they may be **any** Real numeric value. If the threshold value does not appear in the list then the corresponding routines act the same.

Cuban primes between 1e5 and 1.2e5.

    put (1..*).map({ ($_+1)³ - .³ }).grep( &is-prime ).&between(1e5, 1.2e5);
    # 103231 104347 110017 112327 114661 115837

BUGS
====

Mostly intended for monotonic numeric lists/sequences. May work for non-numeric or non-monotonic but not likely to give useful results.

AUTHOR
======

©2022 Stephen Schulze aka thundergnat.

LICENSE
=======

Licensed under The Artistic 2.0; see LICENSE.

