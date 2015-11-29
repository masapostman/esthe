$(document).on 'page:change', ->
  d = new Date()
  $.datepicker.setDefaults({
    dateFormat: "yy-mm-dd",
    minDate: new Date(2015,6,1),
    maxDate: new Date(d.getFullYear() + 1,d.getMonth(),d.getDate() - 1)
    })
  $('.datepicker').datepicker()
