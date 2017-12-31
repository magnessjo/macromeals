$(function () {
  "use strict";


  var observer = new MutationObserver(function (mutations) {
    mutations.forEach(function (mutation) {
      if (mutation.addedNodes && mutation.addedNodes.length > 0) {

        mutation.addedNodes.forEach(function (el) {
          var $el = $(el);

          if ($el.hasClass('lp-editor-container')) {

            eventEditorInit($el);
          }
        });
      }
    });
  });

  var config = {
    attributes: true,
    childList: true,
    characterData: true
  };

  observer.observe(document.body, config);


  $('.calendar-event-wrapper').each(function () {
    eventEditorInit($(this));
  });
});

/**
 * Takes a Craft date format and converts it to moment.js date format
 *
 * @param format
 * @returns string
 */
function convertDateFormatToMomentFormat(format) {
  format = format
    .replace(/m/g, 'M')
    .replace(/d/g, 'D')
    .replace(/yy/g, 'YYYY');

  return format;
}

/**
 * Returns a 2 letter abbreviation based on the day number
 *
 * @param day - int from 0-6
 * @returns {string}
 */
function getDayAbbreviationFromDay(day) {
  day = parseInt(day);
  switch (day) {
    case 0:
      return 'SU';
    case 1:
      return 'MO';
    case 2:
      return 'TU';
    case 3:
      return 'WE';
    case 4:
      return 'TH';
    case 5:
      return 'FR';
    case 6:
      return 'SA';
  }

  throw "Wrong day given: " + day + ". Expected 0-6";
}

Date.prototype.getWeekOfMonth = function (exact) {
  var month           = this.getMonth()
    , year            = this.getFullYear()
    , firstWeekday    = new Date(year, month, 1).getDay()
    , lastDateOfMonth = new Date(year, month + 1, 0).getDate()
    , offsetDate      = this.getDate() + firstWeekday - 1
    , index           = 1 // start index at 0 or 1, your choice
    , weeksInMonth    = index + Math.ceil((lastDateOfMonth + firstWeekday - 7) / 7)
    , week            = index + Math.floor(offsetDate / 7)
  ;
  if (exact || week < 2 + index) return week;
  return week === weeksInMonth ? index + 5 : week;
};

Date.prototype.getNthOfMonth = function () {
  return Math.ceil(this.getDate() / 7);
};


function eventEditorInit(element) {
  var $context = element;

  var $startDate     = $("#calendarEventstartDate-date", $context);
  var $startTime     = $("#calendarEventstartDate-time", $context);
  var $untilChoice   = $("#untilChoice", $context);
  var $untilCount    = $("#calendarEventcount", $context);
  var $untilDate     = $("#calendarEventuntilDate-date", $context);
  var $exceptionDate = $("#calendarEventexceptionDate-date", $context);
  var $selectDate    = $("#calendarEventselectDate-date", $context);
  var $endDate       = $("#calendarEventendDate-date", $context);
  var $endTime       = $("#calendarEventendDate-time", $context);
  var $tabs          = $("#tabs a.tab");

  $startTime.timepicker('option', 'step', calendarTimeInterval);
  $endTime.timepicker('option', 'step', calendarTimeInterval);

  $startDate.datepicker('option', 'onSelect', function (dateText) {
    $endDate.datepicker('option', 'minDate', dateText);
    $endDate.val(dateText);
    $selectDate.datepicker('option', 'minDate', dateText);
    $selectDate.datepicker('option', 'defaultDate', dateText);
    $untilDate.datepicker('option', 'defaultDate', dateText);

    var date = $startDate.datepicker('getDate');
    if (date) {
      date         = new moment(date);
      var day      = getDayAbbreviationFromDay(date.format('d'));
      var monthDay = date.format('D');
      var month    = date.format('M');

      var weekOfMonth = date.toDate().getNthOfMonth();
      if (weekOfMonth > 4) {
        weekOfMonth = -1;
      }

      var $weekly = $('.recurrence-block.recurs-weekly .days', $context);
      if ($('input:checkbox:checked', $weekly).length <= 1) {
        $('input:checkbox:checked', $weekly).prop('checked', false);
        $('input:checkbox[value=' + day + ']', $weekly).prop('checked', true);
      }

      var $monthly = $('.recurrence-block.recurs-monthly .days', $context);
      if ($('input:checkbox:checked', $monthly).length <= 1) {
        $('input:checkbox:checked', $monthly).prop('checked', false);
        $('input:checkbox[value=' + day + ']', $monthly).prop('checked', true);
      }

      var $monthDays = $('.recurrence-block.recurs-monthly .month-days', $context);
      if ($('input:checkbox:checked', $monthDays).length <= 1) {
        $('input:checkbox:checked', $monthDays).prop('checked', false);
        $('input:checkbox[value=' + monthDay + ']', $monthDays).prop('checked', true);
      }

      $('select[name="calendarEvent[monthly][repeatsByDayInterval]"]').val(weekOfMonth);
      $('select[name="calendarEvent[yearly][repeatsByDayInterval]"]').val(weekOfMonth);

      var $yearMonths = $('.recurrence-block.recurs-yearly .months', $context);
      if ($('input:checkbox:checked', $yearMonths).length <= 1) {
        $('input:checkbox:checked', $yearMonths).prop('checked', false);
        $('input:checkbox[value=' + month + ']', $yearMonths).prop('checked', true);
      }

      var $yearly = $('.recurrence-block.recurs-yearly .days', $context);
      if ($('input:checkbox:checked', $yearly).length <= 1) {
        $('input:checkbox:checked', $yearly).prop('checked', false);
        $('input:checkbox[value=' + day + ']', $yearly).prop('checked', true);
      }


    }
  });

  $startTime.on('change', function () {
    var startDate = $startDate.datepicker('getDate');
    var endDate   = $endDate.datepicker('getDate');

    var diffInDays = 0;
    if (startDate && endDate) {
      diffInDays = Math.round((endDate - startDate) / (1000 * 60 * 60 * 24));
    }

    var currentTime  = $startTime.timepicker('getTime');
    var adjustedTime = $startTime.timepicker('getTime');

    if (!currentTime) {
      return;
    }

    adjustedTime.setMinutes(currentTime.getMinutes() + parseInt(calendarEventDuration));

    $endTime.timepicker('option', 'durationTime', currentTime);

    if (diffInDays == 0) {
      var minTime = $startTime.timepicker('getTime');
      minTime.setMinutes(currentTime.getMinutes() + parseInt(calendarTimeInterval));

      $endTime.timepicker('option', 'showDuration', true);
      $endTime.timepicker('option', 'minTime', minTime);
      if ($(this).val()) {
        $endTime.timepicker('setTime', adjustedTime);
      }
    } else {
      $endTime.timepicker('option', 'showDuration', false);
      $endTime.timepicker('option', 'minTime', '00:00');
      if ($(this).val()) {
        $endTime.timepicker('setTime', currentTime);
      }
    }

    $('.calendarCalendarSelect', $context).trigger("change");
  });

  $endTime.on('change', function () {
    var startDate = $startDate.datepicker('getDate');
    var endDate   = $endDate.datepicker('getDate');

    var diffInDays = 0;
    if (startDate && endDate) {
      diffInDays = Math.round((endDate - startDate) / (1000 * 60 * 60 * 24));
    }

    if (!diffInDays) {
      var startTime = $startTime.timepicker('getTime');
      var endTime   = $endTime.timepicker('getTime');

      if (endTime < startTime) {
        var adjustedDate = $startDate.datepicker('getDate');
        adjustedDate.setDate(adjustedDate.getDate() + 1);
        $endDate.datepicker('setDate', adjustedDate);

        $endTime.timepicker('option', 'showDuration', false);
        $endTime.timepicker('option', 'minTime', '00:00');
      }
    }

    $('.calendarCalendarSelect', $context).trigger("change");
  });

  $endDate.on('change', function () {
    $startTime.trigger('change');
  });

  var $allDay = $('.event-all-day .lightswitch', $context);
  $allDay.on({
    change: function () {
      var $timeWrapper = $('[data-affected-by="all-day-toggle"] .timewrapper', $context);
      var $dateRows    = $('.cal-date-row', $context);

      if ($('input', this).val()) {
        $timeWrapper.hide();//fadeOut('fast');
        $dateRows.addClass('short');
      } else {
        setTimeout(function () {
          $timeWrapper.fadeIn('fast');
        }, 300);
        $dateRows.removeClass('short');
      }
    }
  });

  var $recursSwitch = $('.recurrence-switch .lightswitch', $context);
  $recursSwitch.on({
    change: function () {
      var $recurrenceChoices = $('.recurrence-choices', $context);
      var $recurrenceWrapper = $('.recurrence-wrapper', $context);

      if ($('input', this).val()) {
        $recurrenceChoices.removeClass('no-show');
        $recurrenceWrapper.show();
      } else {
        $recurrenceChoices.addClass('no-show');
        $recurrenceWrapper.hide();
      }
    }
  });

  var $yearlyRepeatsBy = $('input[type=checkbox][name$="[yearly][repeatsBy]"]', $context);
  $yearlyRepeatsBy.on({
    change: function () {
      var $recursYearly = $('.recurs-yearly', $context);

      if ($(this).is(':checked')) {
        $recursYearly.slideDown('fast');
      } else {
        $recursYearly.slideUp('fast');
      }
    }
  });

  var $eventFrequency = $('.event-frequency select', $context);
  $eventFrequency.on({
    change: function () {
      var value = $(this).val();

      var $recursWeekly  = $('.recurs-weekly', $context);
      var $recursMonthly = $('.recurs-monthly', $context);
      var $recursYearly  = $('.recurs-yearly', $context);

      var $recursByMonthly = $('.recurrence-choice-monthly', $context);
      var $recursByYearly  = $('.recurrence-choice-yearly', $context);

      var $untilDates     = $('.until-switch', $context);
      var $exceptionDates = $('.exception-dates-wrapper', $context);
      var $selectDates    = $('.select-dates-wrapper', $context);
      var $eventInterval  = $('.event-interval', $context);

      $recursWeekly.slideUp('fast');
      $recursMonthly.slideUp('fast');
      $recursYearly.slideUp('fast');
      $recursByMonthly.slideUp('fast');
      $recursByYearly.slideUp('fast');
      $untilDates.hide();
      $exceptionDates.hide();
      $selectDates.hide();
      $eventInterval.hide();

      switch (value) {
        case 'WEEKLY':
          $recursWeekly.slideDown('fast');
          break;

        case 'MONTHLY':
          $recursMonthly.slideDown('fast');
          $recursByMonthly.slideDown('fast');
          break;

        case 'YEARLY':
          $recursByYearly.slideDown('fast');
          $yearlyRepeatsBy.trigger('change');
          break;
      }

      switch (value) {
        case 'DAILY':
        case 'WEEKLY':
        case 'MONTHLY':
        case 'YEARLY':
          $untilDates.show();
          $exceptionDates.show();
          $eventInterval.show();
          break;

        case 'SELECT_DATES':
          $selectDates.show();
          break;
      }
    }
  });

  var $monthlyRepeatsBy = $('input[type=radio][name$="[monthly][repeatsBy]"]', $context);
  $monthlyRepeatsBy.on({
    change: function () {
      if (!$(this).is(':checked')) {
        return;
      }

      var $daySelector      = $('.recurs-monthly div.days', $context);
      var $monthDaySelector = $('.recurs-monthly div.month-days', $context);

      $daySelector.slideUp('fast');
      $monthDaySelector.slideUp('fast');

      if ($(this).val() == 'byMonthDay') {
        $monthDaySelector.slideDown('fast');
      } else {
        $daySelector.slideDown('fast');
      }
    }
  });

  var $dateList = $('ul.date-list', $context);
  $dateList.on({
    click: function () {
      var $self   = $(this);
      var $parent = $self.parents('li:first');
      var $ul     = $parent.parents('ul:first');

      $parent.remove();
    }
  }, '> li > a');

  $untilChoice.on({
    change: function () {
      var val = $(this).val();

      $untilDate.parents('li:first').hide();
      $untilCount.parents('li:first').hide();
      switch (val) {
        case 'until':
          $untilDate.parents('li:first').fadeIn('fast');
          break;

        case 'count':
          $untilCount.parents('li:first').fadeIn('fast');

          break;
      }
    }
  });

  $exceptionDate.datepicker('option', 'onSelect', function (dateText) {
    var date = new moment(dateText, convertDateFormatToMomentFormat(Craft.datepickerOptions.dateFormat));

    var $li    = $('<li />');
    var $input = $('<input />');
    $input
      .attr('type', 'hidden')
      .attr('name', 'calendarEvent[exceptions][]')
      .val(date.format('YYYY-MM-DD'));

    $li
      .append('<a></a>')
      .append('<span>' + date.format('ll') + '</span>')
      .append($input);

    $(".exception-list", $context).append($li);
    $exceptionDate.val('');
  });

  $selectDate.datepicker('option', 'onSelect', function (dateText) {
    var date = new moment(dateText, convertDateFormatToMomentFormat(Craft.datepickerOptions.dateFormat));

    var $li    = $('<li />');
    var $input = $('<input />');
    $input
      .attr('type', 'hidden')
      .attr('name', 'calendarEvent[selectDates][]')
      .val(date.format('YYYY-MM-DD'));

    $li
      .append('<a></a>')
      .append('<span>' + date.format('ll') + '</span>')
      .append($input);

    $(".select-date-list", $context).append($li);
    $selectDate.val('');
  });

  $selectDate.datepicker('option', 'minDate', $startDate.datepicker('getDate'));

  $allDay.trigger('change');
  $yearlyRepeatsBy.trigger('change');
  $recursSwitch.trigger('change');
  $eventFrequency.trigger('change');
  $monthlyRepeatsBy.trigger('change');
  $untilChoice.trigger('change');

  $tabs.on({
    click: function () {
      var $self = $(this);

      $self.parent().siblings().find('.tab.sel').removeClass('sel');
      $self.addClass('sel');

      $('.tab-content').addClass('hidden');
      $('.tab-content[data-for-tab=' + $self.data('tab-id') + ']').removeClass('hidden');

      return false;
    }
  });
}
