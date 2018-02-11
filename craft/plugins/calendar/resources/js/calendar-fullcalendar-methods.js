var $solspaceCalendar = $("#solspace-calendar");
var $solspaceCalendarSpinner = null;

/**
 * Attaches additional classes to DOM objects
 * based on event parameters
 *
 * @param event
 * @param element
 */
function renderEvent(event, element) {
  if (event.allDay) {
    element.addClass('fc-event-all-day');
  }

  if (!event.end) {
    return;
  }

  if (!event.multiDay && !event.allDay) {
    element.addClass('fc-event-single-day');
    var colorIcon = $('<span />')
      .addClass('fc-color-icon')
      .css('background-color', event.backgroundColor)
      .css('border-color', event.borderColor);
    $('.fc-content', element).prepend(colorIcon);
  } else {
    element.addClass('fc-event-multi-day');
  }

  if (!event.enabled) {
    element.addClass('fc-event-disabled');
  }

  element.addClass('fc-color-' + event.textColor);

  buildEventPopup(event, element);
}

var today = new moment();

/**
 * Attaches links to day numbers
 *
 * @param date
 * @param cell
 */
function renderDay(date, cell) {
  var dayNumberElement = cell
    .parents('.fc-bg:first')
    .siblings('.fc-content-skeleton')
    .find('thead > tr > td:eq(' + cell.index() + ')');

  var link   = getDayViewLink(date);
  var anchor = $('<a />')
    .attr('href', link)
    .html(dayNumberElement.html());

  dayNumberElement.html(anchor);
}

/**
 *
 * @param view
 * @param element
 */
function renderView(view, element) {
  var currentDate = new moment();

  if (view.name == "agendaWeek") {
    var $weekRows = $(".fc-day-header.fc-widget-header", element);

    $weekRows.each(function () {
      var content   = $(this).html();
      var dateParts = content.split(' ');
      content       = dateParts[0] + ' <span>' + dateParts[1] + '</span>';

      var date = new moment($(this).data('date'));
      var link = getDayViewLink(date);

      var $anchor = $('<a />')
        .attr('href', link)
        .html(content);

      if (currentDate.format('YYYYMMDD') == date.format('YYYYMMDD')) {
        $anchor.addClass('fc-title-today');
      }

      $(this).html($anchor);
    });
  }

  $(".fc-localeButton-button", $("#solspace-calendar")).addClass("menubtn btn");

  if (view.name == "agendaDay") {
    $("thead.fc-head", element).remove();
  }

  if (!$solspaceCalendarSpinner) {
    $("#solspace-calendar .fc-right").prepend('<div id="solspace-calendar-spinner" class="spinner" style="display: none;"></div>');
    $solspaceCalendarSpinner = $("#solspace-calendar-spinner");
  }
}

/**
 * Stores the event when it's repositioned
 *
 * @param modification
 * @param event
 * @param delta
 * @param revertFunc
 */
function eventRepositioned(modification, event, delta, revertFunc) {
  var data = {
    eventId: event.id,
    isAllDay: event.allDay,
    startDate: event.start.toISOString(),
    endDate: event.end ? event.end.toISOString() : null,
    deltaSeconds: delta.as("seconds")
  };

  data[csrfTokenName] = csrfTokenValue;

  $.ajax({
    url: Craft.getCpUrl('calendar/events/api/modify' + modification),
    type: 'post',
    dataType: 'json',
    data: data,
    success: function (response) {
      if (response.error) {
        revertFunc();
      } else {
        if (event.repeats) {
          $calendar.fullCalendar('refetchEvents');
        }
      }
    },
    error: function () {
      revertFunc();
    }
  });
}

/**
 * Changes the event date
 *
 * @param event
 * @param delta
 * @param revertFunc
 */
function eventDateChange(event, delta, revertFunc) {
  eventRepositioned("Date", event, delta, revertFunc);
}

/**
 * Changes the event duration
 *
 * @param event
 * @param delta
 * @param revertFunc
 */
function eventDurationChange(event, delta, revertFunc) {
  eventRepositioned("Duration", event, delta, revertFunc);
}

/**
 * Opens the event edit page
 *
 * @param event
 */
function eventClick(event) {
  window.location.href = Craft.getCpUrl('calendar/events/' + event.id);
}

/**
 * Creates a link pointing to a certain date day view
 *
 * @param date - moment instance
 *
 * @returns string
 */
function getDayViewLink(date) {
  if (date.isValid()) {
    var year  = date.format('YYYY');
    var month = date.format('MM');
    var day   = date.format('DD');

    return Craft.getCpUrl('calendar/view/day/' + year + '/' + month + '/' + day);
  }

  return '';
}

/**
 * AJAX POST to get a list of events for a given timeframe
 *
 * @param start
 * @param end
 * @param timezone
 * @param callback
 */
function getEvents(start, end, timezone, callback) {

  getSpinner().fadeIn("fast");

  var $calendarList = $("ul.calendar-list");

  var calendarIds = '*';
  if ($calendarList.length) {
    calendarIds = $("input:checked", $calendarList).map(function () {
      return $(this).val();
    }).get().join();
  }

  var data            = {
    dateRangeStart: start.toISOString(),
    dateRangeEnd: end.toISOString(),
    calendars: calendarIds,
    locale: currentLocaleId,
  };
  data[csrfTokenName] = csrfTokenValue;

  $.ajax({
    url: Craft.getCpUrl('calendar/month'),
    data: data,
    type: 'post',
    dataType: 'json',
    success: function (eventList) {
      callback(eventList);
      getSpinner().fadeOut("fast");
    }
  });
}

var miniCalRefreshTimer = null;

/**
 * Fetches the relevant mini-cal data
 */
function refreshMiniCalendar(date) {
  if (!date) {
    date = $calendar.fullCalendar('getDate').toISOString();
  }

  var $miniCal = $("#mini-cal-wrapper");

  if (!$miniCal.length) {
    return;
  }

  var data = {
    calendars: ($miniCal.data('calendars') + '').split(','),
    date: date,
    locale: currentLocaleId,
  };

  data[csrfTokenName] = csrfTokenValue;

  if (miniCalRefreshTimer) {
    clearTimeout(miniCalRefreshTimer);
  }

  miniCalRefreshTimer = setTimeout(function () {
    Craft.postActionRequest('calendar/view/miniCal', data, function (response) {
      $miniCal.empty().html(response);
    });
  }, 500);
}

/**
 * Closes all open qtips
 */
function closeAllQTips() {
  qTipsEnabled = false;
  $('div.qtip:visible').qtip('hide');
}

function enableQTips() {
  qTipsEnabled = true;
}

function getSpinner() {
  if (!$solspaceCalendarSpinner) {
    $solspaceCalendar.find(".fc-right").prepend('<div id="solspace-calendar-spinner" class="spinner" style="display: none;"></div>');
    $solspaceCalendarSpinner = $("#solspace-calendar-spinner");
  }

  return $solspaceCalendarSpinner;
}
