1.s - subsitute command : echo "one one" | sed 's/one/ONE/'
ONE one
2.& as the matched string : echo "123 abc" | sed 's/[0-9]*/& &/'
123 123 abc


3.use -r to enaeble regular expression for '+' character only
4. use '&' shortcut to use the matched string
echo "123 abc" | sed 's/[0-9]+/& &/'
123 abc
 echo "123 abc" | sed -r 's/[0-9]+/& &/'
123 123 abc

