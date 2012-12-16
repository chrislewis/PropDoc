PropDoc
=======

PropDoc is a silly program for generating basic documentation for simple configuration files.

It mainly exists as an excuse to use Haskell for a program I would actually use.

Build with [cabal](http://www.haskell.org/cabal/) (>= 1.8): `cabal configure --enable-tests && cabal build`
The binary will be available as `dist/build/propdoc/propdoc`. Run this against a Java properties file (one is included in examples): 'dist/build/propdoc/propdoc example/foobar.properties'

This will print the properties to stdout:

<pre>
Name        : foo-name
Description : Foo setting.

Name        : bar-name
Description : Some other.
</pre>
