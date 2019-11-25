(() => {
  $(document).ready(() => {
    const isPopulationsIndexPage = $('.populations_index').length > 0;
    if(!isPopulationsIndexPage) {
      return;
    }

    const $yearInput = $('.populations_index--year');
    const $radioArea = $('.populations_index__radio');
    const furthestKnownYear = parseInt($radioArea.attr('data-furthest-known-year'));
    const sync = () => $radioArea.toggle($yearInput.val() > furthestKnownYear);

    $yearInput.change(sync);
    sync();
  });
})();

