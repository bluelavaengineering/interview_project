(() => {
  // REFACTOR: Not sure if Rails transpiles with Babel by default, but this ES6 syntax will kill some browsers.
  // We'd want to tweak our asset pipeline as needed, later. Also, we'd want to add a .pretterrc and auto-format
  // all JS code -- it's just convenient!
  $(document).ready(() => {
    $('[data-view-data-source-url]').each((_, e) => {
      const url = $(e).attr('data-view-data-source-url');

      setInterval(() => {
        $(e).load(url);
      }, 10000);
    });
  });
})();

