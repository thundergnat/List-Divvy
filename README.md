NAME List::Divvy
================

[![test](https://github.com/thundergnat/List-Divvy/actions/workflows/test.yml/badge.svg)](https://github.com/thundergnat/List-Divvy/actions/workflows/test.yml)

Various shortcut keyword routines to divide up monotonic Positional objects based on element values.

SYNOPSIS
========

    use List::Divvy;

    my $list = 1..∞; # an infinite range

    # show the values in the list before a value greater than or equal to 5
    put $list.&before(5); # 1 2 3 4

    # show the values in the list up to and including a value equal to 5
    put $list.&upto(5); # 1 2 3 4 5

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

Convenience routines to "divvy" up a positional object based on the element values.

When presenting a portion of an array or list, it is simple in Raku to return a specific number or range of elements `@array[^5]`, `@array[15..20]` or some such. Often you need to find the elements whose **value** is in some range. "Show the elements with values less than 100" or "find the elements with values between 25 and 50". There are no built-in routines in Raku to directly do that. It is possible to do but often a little convoluted.

This module exposes several routines to easily partition positionals. These routines are perfectly capable of working with infinite lists and will **not** attempt to reify the whole list to return the requested values.

**Note:** there is at least one other Raku module available ([List::MoreUtils](https://modules.raku.org/dist/List::MoreUtils:zef:zef:lizmat)) that provides similar list partition functionality. [List::MoreUtils](https://modules.raku.org/dist/List::MoreUtils:zef:zef:lizmat) is a Perl 5 port though, and the routines from there are formatted `routine($threshold, @list)` rather than `routine(@list, $threshold)`, which makes it much more difficult to do routine chaining. In this module, the list out from any routine is suitable as the first input parameter to any other routine.

These routines primarily are geared to monotonically increasing numeric values. They can be used with decreasing or variable lists but may not return the results expected.

They will all accept both Real defined numeric values for thresholds, or, Callable blocks or WhateverCodes.

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

Returns the list of values `before()` the given defined value or WhateverCode.

### before( Cool @array, Real $value ); or before( Cool @array, Callable $block );

  * @array

    * Positional object; any array, list or list-like object

  * $value

    * value; any Real number (Rat, Int, or Num)

  * $block

    * callable; an expression, block or WhateverCode that returns a Truthy/Falsey value

Pass in a defined Real value to get all of the elements up to but not including that value.

    put (1..100).&before(10);
    1 2 3 4 5 6 7 8 9

Or a WhateverCode

    put (1..100).&before(* %% 7);
    1 2 3 4 5 6

<a name="after"></a>after( )
----------------------------

Complement to `before()`, `after()` returns the elements greater than the passed in value or code block.

### after( Cool @array, Real $value ); or after( Cool @array, Callable $block );

  * @array

    * Positional object; any array, list or list-like object

  * $value

    * value; any Real number (Rat, Int, or Num)

  * $block

    * callable; an expression, block or WhateverCode that returns a Truthy/Falsey value

Pass in a defined Real value to get all of the elements after but not including that value.

    put (1..10).&after(5);
    6 7 8 9 10

Or a WhateverCode

    put (1..10).&after(* %% 7);
    8 9 10

Use `upto()` and `from()` to partition out value less than or greater than some threshold including the threshold value.

<a name="upto"></a>upto( )
--------------------------

Returns the list of values `upto()` the given defined value or WhateverCode.

### upto( Cool @array, Real $value ); or upto( Cool @array, Callable $block );

  * @array

    * Positional object; any array, list or list-like object

  * $value

    * value; any Real number (Rat, Int, or Num)

  * $block

    * callable; an expression, block or WhateverCode that returns a Truthy/Falsey value

Pass in a defined Real value to get all of the elements up to and including that value.

    put (1..100).&upto(10);
    1 2 3 4 5 6 7 8 9 10

Or a WhateverCode

    put (1..100).&upto(* %% 7);
    1 2 3 4 5 6 7

<a name="from"></a>from( )
--------------------------

Complement to `upto()`, `from()` returns the elements greater than or equal to the passed in value or code block.

### from( Cool @array, Real $value ); or from( Cool @array, Callable $block );

  * @array

    * Positional object; any array, list or list-like object

  * $value

    * value; any Real number (Rat, Int, or Num)

  * $block

    * callable; an expression, block or WhateverCode that returns a Truthy/Falsey value

Pass in a defined Real value to get all of the elements greater than or equal to that value.

    put (1..10).&from(5);
    5 6 7 8 9 10

Or a WhateverCode

    put (1..10).from(* %% 7);
    7 8 9 10

Similar to the single ended partition routines, there are routines `between` and `bounded`.

<a name="between"></a>between( )
--------------------------------

Returns the list of values `between()` the two boundary values.

### between( Cool @array, Real (or Callable) $lo, Real (or Callable) $hi );

  * @array

    * Positional object; any array, list or list-like object

  * $lo

    * value; lower threshold, any Real number (Rat, Int, or Num) or Callable

  * $hi

    * value; upper threshold, any Real number (Rat, Int, or Num) or Callable

Gets all of the elements between but not including the threshold values.

    put (1..100).&between(23, 29);
    24 25 26 27 28

<a name="bounded"></a>bounded( )
--------------------------------

Returns the list of values `bounded()` by the two threshold values.

### bounded( Cool @array, Real (or Callable) $lo, Real (or Callable) $hi );

  * @array

    * Positional object; any array, list or list-like object

  * $lo

    * value; lower threshold, any Real number (Rat, Int, or Num) or Callable

  * $hi

    * value; upper threshold, any Real number (Rat, Int, or Num) or Callable

Get all of the elements bounded by, and including the threshold values.

    put (1..100).&bounded(23, 29);
    23 24 25 26 27 28 29

You may also combine and chain the single ended partitions in various combinations to include or exclude the upper and lower thresholds as desired.

    put (1..20).&after(4).&upto(12);
    5 6 7 8 9 10 11 12

Note that these examples have all used integers, but they may be **any** Real numeric value. If the threshold value does not appear in the list then the corresponding routines act the same.

Cuban primes between 1e5 and 1.2e5:

    put (1..*).map({ ($_+1)³ - .³ }).grep( &is-prime ).&between(1e5, 1.2e5);
    103231 104347 110017 112327 114661 115837

Random interval sequence with non-Int boundaries:

    put (0, *+.01 * rand … *).&between(3.575, 3.6045);
    3.5875642424525935 3.5922439090572023 3.6003421569736993 3.6024701972903563

The callable block may be a WhateverCode or may be an actual block.

Powers of 3, filtered to show the first with 5 digits, through the first with more than 7 digits:

    put (1, 3, 9, 27 … *).&bounded( *.chars == 5, {.chars > 7} );
    19683 59049 177147 531441 1594323 4782969 14348907

BUGS
====

Mostly intended for monotonic numeric lists/sequences. May work for non-numeric or non-monotonic but not likely to give useful results.

AUTHOR
======

©2022 Stephen Schulze aka thundergnat.

LICENSE
=======

Licensed under The Artistic 2.0; see LICENSE.

