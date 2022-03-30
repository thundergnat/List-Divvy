use List::Divvy;

use Test;

is-deeply( (1..10).&before(5), (1,2,3,4), '&before as expected');
is-deeply( (1..10).&upto(5), (1,2,3,4,5), '&upto as expected');
is-deeply( (1..10).&after(5), (6,7,8,9,10), '&after as expected');
is-deeply( (1..10).&from(5), (5,6,7,8,9,10), '&from as expected');
is-deeply( (1..10).&between(5,8), (6,7), '&between as expected');
is-deeply( (1..10).&bounded(5,8), (5,6,7,8), '&bounded as expected');

is-deeply( (1..*).map({ ($_+1)³ - .³ }).grep( &is-prime ).&upto(1000),(7,19,37,61,127,271,331,397,547,631,919), 'more complicated sequence upto bound not in sequence ok');
is-deeply( (1..*).map({ ($_+1)³ - .³ }).grep( &is-prime ).&before(1000),(7,19,37,61,127,271,331,397,547,631,919), 'more complicated sequence before bound not in sequence ok');
is-deeply( (1..*).map({ ($_+1)³ - .³ }).grep( &is-prime ).&upto(1657),(7,19,37,61,127,271,331,397,547,631,919,1657), 'more complicated sequence upto bound in sequence ok');
is-deeply( (1..*).map({ ($_+1)³ - .³ }).grep( &is-prime ).&before(1657),(7,19,37,61,127,271,331,397,547,631,919), 'more complicated sequence before bound in sequence ok');

done-testing;
