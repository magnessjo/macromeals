var viewSpecificOptions = {
  week: {
    titleFormat: "MMMM D, YYYY",
    columnFormat: "ddd D",
    timeFormat: 'LT',
    slotLabelFormat: 'LT'
  },
  day: {
    titleFormat: 'dddd, MMMM D, YYYY',
    columnFormat: '',
    timeFormat: 'LT',
    slotLabelFormat: 'LT'
  }
};

var selectedCalendarsStorageKey = "calendar-selectedCalendars";
var qTipsEnabled                = true;
var $calendar                   = $('#solspace-calendar');
var $miniCal                    = $("#calendar-mini-cal");

var isLocalized = Craft.isLocalized;

$(function () {
  "use strict";

  var defaultDay = new moment();
  if (typeof calendarCurrentDay !== "undefined") {
    defaultDay = new moment(calendarCurrentDay);
  }

  var customButtons = {
    refresh: {
      text: Craft.t('Refresh'),
      click: function () {
        $calendar.fullCalendar('refetchEvents');
      }
    }
  };

  if (isLocalized) {
    customButtons["localeButton"] = {
      text: localeMap[currentLocaleId],
      click: function (event) {
        var localeButton = $(".fc-localeButton-button", $calendar);

        if (localeButton.data("initialized") === undefined) {
          var $menu     = $("<div>", {class: "menu"}).insertAfter(event.currentTarget);
          var $localeUl = $("<ul>").appendTo($menu);

          for (var key in localeMap) {
            if (!localeMap.hasOwnProperty(key)) continue;

            $("<li>")
              .append(
                $("<a>", {
                  "data-locale-id": key,
                  text: localeMap[key]
                })
              )
              .appendTo($localeUl);
          }

          new Garnish.MenuBtn(
            event.currentTarget,
            {
              onOptionSelect: function (target) {
                currentLocaleId = $(target).data("locale-id");

                localeButton.text(localeMap[currentLocaleId]);
                $calendar.fullCalendar("refetchEvents");
              }
            }
          ).showMenu();

          localeButton.data("initialized", true);
        }
      }
    };
  }

  $calendar.fullCalendar({
    defaultDate: defaultDay,
    defaultView: $calendar.data('view'),
    nextDayThreshold: "0" + calendarOverlapThreshold + ":00:01",
    fixedWeekCount: true,
    eventLimit: 5,
    aspectRatio: 1.3,
    editable: canEditEvents,
    lang: calendarLocale,
    views: viewSpecificOptions,
    firstDay: calendarFirstDayOfWeek,
    viewRender: renderView,
    events: getEvents,
    eventRender: renderEvent,
    dayRender: renderDay,
    eventDragStart: closeAllQTips,
    eventDragStop: enableQTips,
    eventDrop: eventDateChange,
    eventResizeStart: closeAllQTips,
    eventResizeStop: enableQTips,
    eventResize: eventDurationChange,
    selectable: canQuickCreate && canEditEvents,
    selectHelper: canQuickCreate && canEditEvents,
    select: showEventCreator,
    unselectAuto: false,
    customButtons: customButtons,
    header: {
      right: 'localeButton refresh prev,today,next',
      left: 'title'
    }
  });

  if ($calendar.fullCalendar('getView').name !== 'month') {
    $calendar.fullCalendar('option', 'height', 'auto');
  }

  $('.fc-next-button, .fc-prev-button, .fc-today-button', $calendar).on({
    click: function () {
      var viewType = $calendar.fullCalendar('getView').type;
      var date     = $calendar.fullCalendar('getDate');

      var year  = date.format('YYYY');
      var month = date.format('MM');
      var day   = date.format('DD');

      var view = 'month';
      switch (viewType) {
        case 'agendaDay':
          view = 'day';
          break;

        case 'agendaWeek':
          view = 'week';
          break;
      }

      var url = Craft.getCpUrl('calendar/view/' + view + '/' + year + '/' + month + '/' + day);

      history.pushState('data', '', url);
    }
  });

  $('.alert-dismissible a.close').on({
    click: function () {
      var $alert = $(this).parents(".alert:first");
      Craft.postActionRequest('calendar/view/dismissDemoAlert', {}, function (response) {
        $alert.remove();
      });
    }
  });

  $('.calendar-list input').on({
    change: function () {
      var storageData = {};

      $("ul.calendar-list input").map(function () {
        storageData[$(this).val()] = $(this).is(":checked");
      }).get().join();

      localStorage.setItem(selectedCalendarsStorageKey, JSON.stringify(storageData));

      var usedCalendarIds = [];
      for (var key in storageData) {
        if (!storageData.hasOwnProperty(key)) continue;

        if (storageData[key]) {
          usedCalendarIds.push(key);
        }
      }

      $miniCal.data('calendars', usedCalendarIds.join(","));
      $miniCal.fullCalendar("refetchEvents");

      $calendar.fullCalendar('refetchEvents');
    }
  });

  var $eventCreator = $('#event-creator');
  var $allDay       = $('.lightswitch', $eventCreator);
  $allDay.on({
    change: function () {
      var $timeWrapper = $('.timewrapper', $eventCreator);

      if ($('input', this).val()) {
        $timeWrapper.fadeOut('fast');
      } else {
        $timeWrapper.fadeIn('fast');
      }
    }
  });
});

var selectedCalendars = localStorage.getItem(selectedCalendarsStorageKey);
if (selectedCalendars != null) {
  var usedCalendarIds = [];
  var allCalendarIds  = $("ul.calendar-list input").map(function () {
    return parseInt($(this).val());
  }).get();

  var calendarMap = {};
  if (selectedCalendars.substring(0, 1) === "{") {
    calendarMap = JSON.parse(selectedCalendars);
  }

  for (var index = 0; index < allCalendarIds.length; index++) {
    var calendarId = allCalendarIds[index];

    if (calendarMap[calendarId] == undefined) {
      calendarMap[calendarId] = true;
      usedCalendarIds.push(calendarId);
    } else if (calendarMap[calendarId] == true) {
      usedCalendarIds.push(calendarId);
    }
  }

  $miniCal.data('calendars', usedCalendarIds.join(","));
  $miniCal.fullCalendar("refetchEvents");
  $(".calendar-list input").each(function () {
    var calendarId = $(this).val();
    var isSelected = calendarMap[calendarId] == undefined || calendarMap[calendarId] == true;
    $(this).prop('checked', isSelected);
  });
}
