var eventCreatorShown = false;

/**
 * qTip2 Modal window of "Event Create"
 *
 * @param start
 * @param end
 */
function showEventCreator(start, end) {
  if (eventCreatorShown) {
    return;
  }

  eventCreatorShown = true;

  /*
   * Since the dialogue isn't really a tooltip as such, we'll use a dummy
   * out-of-DOM element as our target instead of an actual element like document.body
   */
  $('<div />').qtip({
    content: {
      text: $('#event-creator'),
      title: Craft.t("New Event")
    },
    position: {
      my: 'center',
      at: 'center',
      target: $(window)
    },
    show: {
      ready: true,
      modal: {
        on: true,
        blur: false
      }
    },
    hide: false,
    style: {
      classes: 'qtip-bootstrap dialogue',
      width: 500
    },
    events: {
      render: function (event, api) {
        var context = api.elements.content;

        $('ul.errors', context).empty();

        var startTime = start.utc().format('HHmmss');
        var endTime = end.utc().format('HHmmss');

        var isAllDay = false;
        if (startTime === endTime && endTime == "000000") {
          end.subtract(1, 'seconds');
          isAllDay = true;
        }

        var utcStart = createDateAsUTC(start.toDate());
        var utcEnd = createDateAsUTC(end.toDate());

        var $creator = $('#event-creator');
        $creator.addClass('shown');
        var $startDate = $('#startDate-date', $creator);
        var $startTime = $('#startDate-time', $creator);
        var $endDate = $('#endDate-date', $creator);
        var $endTime = $('#endDate-time', $creator);

        $startDate.datepicker('setDate', utcStart);
        $endDate.datepicker('setDate', utcEnd);
        $startTime.timepicker('setTime', utcStart);
        $endTime.timepicker('setTime', utcEnd);

        var $allDayInput = $('input[name=allDay]');
        var lightswitch = $allDayInput.parents('.lightswitch:first');
        $('input', lightswitch).val(isAllDay ? 1 : '');
        if (isAllDay) {
          lightswitch.data('lightswitch').turnOn();
          $('.timewrapper', $creator).hide();
        } else {
          lightswitch.data('lightswitch').turnOff()
          $('.timewrapper', $creator).show();
        }

        setTimeout(function () {
          $("input[name=title]:first", context)
            .val('')
            .focus()
            .bind('keypress', function (e) {
              var key = e.which ? e.which : e.keyCode;

              if (key == 13) { // ENTER
                $("button.submit", context).trigger('click');
              }
            });
        }, 100);

        var timeFormat = $startTime.timepicker('option', 'timeFormat')
        var momentTimeFormat = timeFormat
          .replace('h', 'hh')
          .replace('H', 'HH')
          .replace('G', 'H')
          .replace('g', 'h')
          .replace('A', 'a')
          .replace('i', 'mm');

        $("button.submit", context).unbind('click').click(function (e) {
          var title = $('input[name=title]', context).val();
          var calendarId = $('select[name=calendarId]', context).val();

          var startDateValue = moment($startDate.datepicker('getDate'));
          var startTimeValue = moment($startTime.val().replace(/(a|p)\.(m)\./ig, '$1$2'), momentTimeFormat);
          var endDateValue = moment($endDate.datepicker('getDate'));
          var endTimeValue = moment($endTime.val().replace(/(a|p)\.(m)\./ig, '$1$2'), momentTimeFormat);

          var data = {
            startDate: startDateValue.format('YYYY-MM-DD') + ' ' + startTimeValue.format('HH:mm:ss'),
            endDate: endDateValue.format('YYYY-MM-DD') + ' ' + endTimeValue.format('HH:mm:ss'),
            allDay: $allDayInput.val(),
            event: {
              title: title,
              calendarId: calendarId
            }
          };

          data[csrfTokenName] = csrfTokenValue;

          $.ajax({
            url: Craft.getCpUrl('calendar/events/api/create'),
            type: 'post',
            dataType: 'json',
            data: data,
            success: function (response) {
              if (response.error) {
                $('ul.errors', context)
                  .empty()
                  .append($('<li />', {text: response.error}));
              } else if (response.event) {
                $calendar.fullCalendar('renderEvent', response.event);
                $calendar.fullCalendar('unselect');

                api.hide(e);
              }
            },
            error: function (response) {
              alert(response);
            }
          });
        });

        $('button.delete', context).unbind('click').click(function (e) {
          api.hide();
        });
      },
      hide: function (event, api) {
        $('#event-creator').removeClass('shown').insertAfter($calendar);
        $calendar.fullCalendar('unselect');
        eventCreatorShown = false;
        api.destroy();
      }
    }
  });
}

/**
 * Attaches a qTip2 popup on a given event
 *
 * @param event
 * @param element
 */
function buildEventPopup(event, element) {
  if (!event.calendar) {
    return;
  }

  var qtipContent = $('<div>');
  var calendarData = $('<div>', {
    class: 'calendar-data',
    html: '<span class="color-indicator" style="background-color: ' + event.backgroundColor + ';"></span> ' + event.calendar.name
  });

  var start = moment(event.start);
  var end = moment(event.end);

  var dateFormat = 'dddd, MMMM D, YYYY';
  if (event.allDay) {
    end.subtract(1, 'days');
  } else {
    var timeFormat = calendarTimeFormat == "H:i" ? "HH:mm" : "h:mma"
    dateFormat = dateFormat + ' \\a\\t ' + timeFormat;
  }

  var eventRange = $('<div>', {
    class: 'event-date-range separator',
    html: '<div style="white-space: nowrap;"><label>' + Craft.t('Starts') + ':</label>' + start.format(dateFormat) + '</div>' +
    '<div style="white-space: nowrap;"><label>' + Craft.t('Ends') + ':</label>' + end.format(dateFormat) + '</div>'
  });

  var eventRepeats = '';
  if (event.repeats) {
    eventRepeats = $('<div>', {
      class: 'event-repeats separator',
      html: '<label>' + Craft.t('Repeats') + ':</label>' + event.readableRepeatRule
    });
  }

  if (event.editable) {
    var editButton = $('<div>', {
      class: 'buttons'
    });

    editButton.append($('<a>', {
      class: 'btn small submit',
      href: Craft.getCpUrl('calendar/events/' + event.id + (Craft.isLocalized ? '/' + currentLocaleId : '')),
      text: Craft.t('Edit')
    }));

    editButton.append($('<a>', {
      class: 'btn small delete-event',
      href: Craft.getCpUrl('calendar/events/api/delete'),
      text: Craft.t('Delete'),
      data: {
        id: event.id
      }
    }));

    if (event.repeats) {
      editButton.append($('<a>', {
        class: 'btn small delete-event-occurrence',
        href: Craft.getCpUrl('calendar/events/api/deleteOccurrence'),
        text: Craft.t('Delete occurrence'),
        data: {
          id: event.id,
          date: event.start.toISOString()
        }
      }));
    }
  }

  element.qtip({
    content: {
      title: event.title,
      button: true,
      text: qtipContent
        .add(calendarData)
        .add(eventRange)
        .add(eventRepeats)
        .add(editButton)
    },
    style: {
      classes: 'qtip-bootstrap qtip-event',
      tip: {
        width: 30,
        height: 15
      }
    },
    position: {
      my: 'right center',
      at: 'left center',
      viewport: $(window),
      adjust: {
        method: 'shift flip'
      }
    },
    show: {
      solo: true,
      delay: 500
    },
    hide: {
      fixed: true,
      delay: 300
    },
    events: {
      show: function (e, api) {
        if (!qTipsEnabled) {
          e.preventDefault();
        }
      },
      render: function (e, api) {
        $('a.delete-event-occurrence', api.elements.content).click(function (e) {
          var url = $(this).attr('href');
          var eventId = $(this).data('id');
          var date = $(this).data('date');

          if (confirm(Craft.t('Are you sure?'))) {
            var data = {
              eventId: eventId,
              date: date
            };

            data[csrfTokenName] = csrfTokenValue;

            $.ajax({
              url: url,
              type: 'post',
              dataType: 'json',
              data: data,
              success: function (response) {
                if (!response.error) {
                  $calendar.fullCalendar('removeEvents', function (lookupEvent) {
                    return lookupEvent.id == event.id && lookupEvent.start.isSame(event.start);
                  });
                  api.destroy();

                  return;
                }

                alert(response.error);
              }
            });
          }

          return false;
        });

        $('a.delete-event', api.elements.content).click(function (e) {
          var url = $(this).attr('href');
          var eventId = $(this).data('id');

          if (confirm(Craft.t('Are you sure you want to delete this event?'))) {
            var data = {
              eventId: eventId
            };

            data[csrfTokenName] = csrfTokenValue;

            $.ajax({
              url: url,
              type: 'post',
              dataType: 'json',
              data: data,
              success: function (response) {
                if (!response.error) {
                  $calendar.fullCalendar('removeEvents', event.id);
                  api.destroy();

                  return;
                }

                alert(response.error);
              }
            });
          }

          return false;
        });
      }
    }
  });
}


function createDateAsUTC(date) {
  return new Date(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate(), date.getUTCHours(), date.getUTCMinutes(), date.getUTCSeconds());
}
