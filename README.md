# JavaScript Patterns snippets

<img
  src="https://raw.github.com/caiogondim/js-patterns-sublime-snippets/assets/js-patterns-logo.png"
  alt="JS Patterns logo" align="right"
/>

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
If you insist to not install it, you can download the package and put it manually
inside your Pacakages directory. It should work but will not update
automatically.


## Snippets

Some JS Patterns snippets in the wild.

<img
  src="https://raw.github.com/caiogondim/js-patterns-sublime-snippets/assets/in-the-wild.gif"
  alt="In the wild"
/>


## Immediate function

**trigger**: ifun⇥

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

**trigger**: forin⇥

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


## Module pattern

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

## Throttle

The function will be called no more than one time every X seconds, even if you
call it repeatedly. Useful for some DOM events like the resize event on the
window.

```javascript
var onResize = (function () {
  'use strict';

  var timeWindow = 200; // time in ms
  var lastExecution = new Date((new Date()).getTime() - timeWindow);

  var onResize = function (args) {
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
var autocomplete = (function () {
  'use strict';

  var timeWindow = 500; // time in ms
  var timeout;

  var autocomplete = function (arg1, arg2) {
    // your code goes here
  };

  return function() {
    var context = this;
    var args = arguments;
    clearTimeout(timeout);
    timeout = setTimeout(function(){
      autocomplete.apply(context, args);
    }, timeWindow);
  };
}());
```

Reference:
- [Underscore.js](http://davidwalsh.name/function-debounce)
- [David Walsh](http://davidwalsh.name/function-debounce)


## Support

All the snippets should run in:
- Chrome
- Safari
- Firefox
- Internet Explorer 8.0+
- Opera 15+
- Node.js 0.10+

If you found some error, please open an issue or send a pull request.
