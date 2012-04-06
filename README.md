array-unit
==========

Array methods inspired by [Groovy's collection methods](http://groovy.codehaus.org/Collections).


Add new methods in Javascript Array class if not exist...
    
    unless Array::remove
      Array::remove = (fn) ->
      ...


Examples 
--------
    
    array = [{username:"me"},{username:"meToo"},{username:"meOfCourse"}]
    array.remove (player) -> player.username == "meToo"


Installation
------------

Clone / download array-util from [github](https://github.com/amallo/array-util).


Usage
-----

In nodejs environnement simply add:

    arrayUtil = require "path/to/array-util"

See [unit tests](https://github.com/amallo/array-util/blob/master/test/array-util-test.coffee) to know how to use it.

Tests
-----

Tests are written with [nodeunit](https://github.com/caolan/nodeunit).


Contributing
------------

Feel free to fork and improve ;)