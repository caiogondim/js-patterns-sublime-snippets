# JavaScript patterns snippets

Snippets for [Sublime Text](http://www.sublimetext.com/) with **good solutions
for regular situations** in JavaScript.

Work in progress. Soon available in **Package Control**.

## Immediate function

**trigger**: ifun + TAB

To keep the global scope clean and to use strict mode in a controlled
enviroment, without triggering it in the global scope.

```javascript
(function () {
    'use strict';
    // closure scope
}());
```

Reference:
- [StackOverflow: Immediate functions JavaScript](http://stackoverflow.com/questions/13364312/immediate-functions-javascript)

## For in

**trigger**: forin + TAB

For-in loops in JavaScript will iterate over new properties added to the
prototype chain of the object we are iterating.
To loop through only in the object's properties, we have to use
`.hasOwnProperty('propertyName')`. Like below.

```javascript
for (var prop in obj) {
  if (obj.hasOwnProperty(prop)) {
    obj.prop;
  }
}
```

Reference:
- [JavaScript Patterns, by Stoyan Stefanov](http://shop.oreilly.com/product/9780596806767.do)
- [The Essentials of Writing High Quality JavaScript](http://net.tutsplus.com/tutorials/javascript-ajax/the-essentials-of-writing-high-quality-javascript/)

## Constructor pattern

**trigger**: constructor + TAB

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

})();
```

Reference:
- [Object Creation patterns](http://www.jspatterns.com/category/patterns/object-creation/)

## Module pattern

**trigger**: module + TAB

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

})();
```

Reference:
- [JavaScript Module Pattern: In-Depth](http://www.adequatelygood.com/JavaScript-Module-Pattern-In-Depth.html)

## Memoization

Caches the return value of function. Useful for repetitive calls for a
computationally expensive function.

```javascript
var expensiveFunction = (function() {
  'use strict';

  var funcMemoized = function() {
    var cacheKey = JSON.stringify(Array.prototype.slice.call(arguments));
    var result;

    if (!funcMemoized.cache[cacheKey]) {
        // your expensive computation goes here

        funcMemoized.cache[cacheKey] = result;
    }

    return funcMemoized.cache[cacheKey];
  }

  funcMemoized.cache = {};

  return funcMemoized;
}());
```
