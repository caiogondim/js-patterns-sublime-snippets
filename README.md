# JavaScript Patterns snippets <img alt="Build Status" src="https://secure.travis-ci.org/caiogondim/js-patterns-sublime-snippets.png?branch=master"> <img alt="Downloads per month" src="https://img.shields.io/packagecontrol/dm/JavaScript%20Patterns.svg">

<img src="https://raw.github.com/caiogondim/js-patterns-sublime-snippets/assets/js-patterns-logo.png" alt="JS Patterns logo" align="right" />

Snippets for [Sublime Text](http://www.sublimetext.com/) with **good solutions
for regular problems** in JavaScript.

> In software engineering, a design pattern is a general reusable
> solution to a commonly occurring problem within a given context in software
> design.
>
> – Wikipedia

To install through Package Control, search for **JavaScript Patterns**. If you
still don't have Package Control in Sublime Text,
[go get it](http://wbond.net/sublime_packages/package_control/installation).
If you insist to not install it, you can download the package and put it
manually inside your Pacakages directory. It should work but will not update
automatically.


## Snippets

Some JS Patterns snippets in the wild.

<img src="http://cdn1.caiogondim.com/js-patterns-sublime-snippets-preview.gif" alt="Preview" />


## Immediate function

**trigger**: ifun⇥

To keep the global scope clean and to use strict mode in a controlled
enviroment, without triggering it in the global scope.

```javascript
;(function() {
    'use strict';
    // closure scope
}());
```

Reference:
- [StackOverflow: Immediate functions JavaScript](http://stackoverflow.com/questions/13364312/immediate-functions-javascript)


## For in

**trigger**: forin⇥

For-in loops in JavaScript will iterate over new properties added to the
prototype chain of the object we are iterating.
To loop through only in the object's properties, we have to use
`.hasOwnProperty('propertyName')`. Like below.

```javascript
for (var prop in obj) {
  if ({}.hasOwnProperty.call(obj, prop)) {
    obj[prop];
  }
}
```

Reference:
- [JavaScript Patterns, by Stoyan Stefanov](http://shop.oreilly.com/product/9780596806767.do)
- [The Essentials of Writing High Quality JavaScript](http://net.tutsplus.com/tutorials/javascript-ajax/the-essentials-of-writing-high-quality-javascript/)


## Object.keys loop

**trigger**: okl⇥

If your enviroment supports that method, prefer this over `for in`.

```javascript
Object.keys(obj).forEach(function(key) {
  // inside loop
});
```


## Improved for loop

**trigger:** ifor⇥

A faster way to write a `for` loop. It caches the array size, so we don't need
to recalculate the size at every iteration.

```javascript
for (i = 0, len = arr.length; i < len; i++) {
  // array length is calculated only 1 time and then stored
}
```

Reference:
- [Browser Diet](http://browserdiet.com/#cache-array-lengths)


## Constructor pattern

**trigger**: constructor⇥

That constructor pattern enforces the use of `new`, even if you call the
constructor like a function. In JavaScript, if the `new` keyword is forgotten,
`this` will reference the global object inside the constructor, and that's never
a desirable situation.

That approach is like `$()` and `$.Deferred()` in jQuery, where you can call
it in the same way with `new $()` and `new $.Deferred`.

```javascript
var ConstructorName = (function() {
  'use strict';

  function ConstructorName(arg1, arg2) {
    // enforces new
    if (!(this instanceof ConstructorName)) {
        return new ConstructorName();
    }

    // constructor body
  }

  ConstructorName.prototype.someMethod = function(arg) {
    // method body
  }

  return ConstructorName;
}());
```

Reference:
- [Object Creation patterns](http://www.jspatterns.com/category/patterns/object-creation/)


## Singleton pattern

**trigger**: singleton⇥

With the Singleton pattern there will be only one instance of a constructor
function. If you try to instantiate another one, the first instance that was
created at first will be returned.

```javascript
var singletonName = (function() {
  'use strict';

  var instance;

  singletonName = function() {
    if (instance) {
      return instance;
    }

    instance = this;

    // your code goes here
  };

  return singletonName;
}());

```

Reference:
- [Singleton Pattern - Simples Ideias](http://simplesideias.com.br/design-patterns-no-javascript-singleton)


## Module

**trigger**: module⇥

A simple module pattern. Uses strict mode and suggest the use of a `init`
function for kickoff. Also possible to define some "private" methods and
variables. Only the variable with the module's name is returned and therefore
made public outside the closure.

```javascript
var moduleName = (function() {
  'use strict';

  var privateVar = '';

  var moduleName = {
    init: {
      // kickoff
    }
  }

  return moduleName;
}());
```

Reference:
- [JavaScript Module Pattern: In-Depth](http://www.adequatelygood.com/JavaScript-Module-Pattern-In-Depth.html)


## Revealing module

**trigger**: rmodule⇥

Some might say it's a less verbose and more organized way to define a module.
It declares all the variables and functions in the private scope and returns
an object with references to what is going to be public.

```javascript
var revealingModule = (function() {
  'use strict';

  var privateVar = 'foo';
  var publicVar = 'bar';

  function privateFunction() {

  }

  function publicFunction() {

  }

  return {
    publicVar: publicVar,
    publicFunction: publicFunction
  };
}());
```

## AMD

**trigger**: amdmod⇥

> The Asynchronous Module Definition (AMD) API specifies a mechanism for defining
> modules such that the module and its dependencies can be asynchronously loaded.
> This is particularly well suited for the browser environment where synchronous
> loading of modules incurs performance, usability, debugging, and cross-domain
> access problems.

```js
define([
    "module1"
], function(module1) {
    "use strict";

    // static public property
    myModule.prop;

    var myModule = function() {

        // public var
        this.b = null;

        // pseudo-protected var
        this._c = null;

    };

    function privateMethod(args) {
    };

    myModule.staticMethod = function(args) {
    };

    myModule.prototype.publicMethod = function(args) {
    };

    return myModule;
});
```

Reference:
- [AMD API](https://github.com/amdjs/amdjs-api/wiki/AMD)

## Memoization

Caches the return value of function. Useful for repetitive calls for a
computationally expensive function.

```javascript
var expensiveFunction = (function() {
  'use strict';

  var funcMemoized = function() {
    var cacheKey = JSON.stringify(Array.prototype.slice.call(arguments));
    var result;

    if (!funcMemoized.cache.hasOwnProperty(cacheKey)) {
        // your expensive computation goes here

        funcMemoized.cache[cacheKey] = result;
    }

    return funcMemoized.cache[cacheKey];
  }

  funcMemoized.cache = {};

  return funcMemoized;
}());
```

## Throttle

The function will be called no more than one time every X seconds, even if you
call it repeatedly. Useful for some DOM events like the resize event on the
window.

```javascript
var onResize = (function() {
  'use strict';

  var timeWindow = 200; // time in ms
  var lastExecution = new Date((new Date()).getTime() - timeWindow);

  var onResize = function(args) {
    // your code goes here
  };

  return function() {
    if ((lastExecution.getTime() + timeWindow) <= (new Date()).getTime()) {
      lastExecution = new Date();
      return onResize.apply(this, arguments);
    }
  };
}());
```

Reference:
- [Underscore.js](http://underscorejs.org/docs/underscore.html#section-64)


## Debounce

The function will postpone its execution until X miliseconds have elapsed since
the last call. Useful for some events that you want to happen after some time
after the last interaction, like an autocomplete or a double-click in a submit
button.

```javascript
var autocomplete = (function() {
  'use strict';

  var timeWindow = 500; // time in ms
  var timeout;

  var autocomplete = function(arg1, arg2) {
    // your code goes here
  };

  return function() {
    var context = this;
    var args = arguments;
    clearTimeout(timeout);
    timeout = setTimeout(function() {
      autocomplete.apply(context, args);
    }, timeWindow);
  };
}());
```

Reference:
- [Underscore.js](http://davidwalsh.name/function-debounce)
- [David Walsh](http://davidwalsh.name/function-debounce)

## Namespace
**trigger**: namespace⇥

Namespacing is a technique employed to avoid collisions with other objects or
variables in the global namespace. They're also extremely useful for helping
organize blocks of functionality in your application into easily manageable
groups that can be uniquely identified. Extensibility is of course key to any
scalable namespacing pattern and IIFEs can be used to achieve this quite easily.


```javascript
;(function(namespace) {
  'use strict';

  // your code goes here
  // namespace.method = function(){};
})(window.namespace = window.namespace || {});
```

Reference:
- [Addy Osmani - Essential JS Namespacing](http://addyosmani.com/blog/essential-js-namespacing/)

## Once
**trigger**: once⇥

Creates a function that can only be executed one time.

```javascript
var once = (function() {
  var didRun = false;

  // This function will be executed only once, no matter how many times
  // it is called.
  function once() {
    // ...
  }

  return function() {
    if (didRun) {
      return;
    }

    didRun = true;

    return foo.apply(this, arguments);
  }
})();
```

## Contributors

```
59  Caio Gondim
01  Arne Schlüter
01  Breno Calazans
01  Philip Blyth
01  gaboesquivel
```

## Donating

If you found this project useful and are willing to donate, transfer some
bitcoins to `1BqqKiZA8Tq43CdukdBEwCdDD42jxuX9UY` or through the
[URL](https://www.coinbase.com/caiogondim) https://www.coinbase.com/caiogondim

Or via [PayPal.me](https://www.paypal.me/caiogondim) https://www.paypal.me/caiogondim.

## License
The MIT License (MIT)

Copyright (c) 2014 [Caio Gondim](http://caiogondim.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
