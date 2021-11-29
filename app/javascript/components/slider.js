const rangeSlider = () => {
  var slider = $('.range-slider'),
    range = $('.range-slider__range'),
    value = $('.range-slider__value');
  console.log(slider);
  console.log(range);
  console.log(value);

  slider.each(function () {
    console.log('slide');
    value.each(function () {
      var value = $(this).prev().attr('value');
      $(this).html(value);
    });
    console.log('slide again');
    range.on('input', function () {
      console.log(this)
      console.log(this.value)
      $(this).parent().next(value).html(this.value);
    });
  });
};

export { rangeSlider };
