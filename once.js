var once = (function() {
  var didRun = false;

  function foo() {
    console.log('foo');
  }

  return function() {
    if (didRun) {
      return;
    }

    didRun = true;

    return foo.apply(foo, arguments);
  }
})();

once(1)
once(2)
once(3)
