var viewSpecificOptions = {
    week: {
        columnFormat: "ddd D",
        timeFormat: 'LT',
        slotLabelFormat: 'LT'
    },
    day: {
        columnFormat: '',
        timeFormat: 'LT',
        slotLabelFormat: 'LT'
    }
};

function initiateAgenda(elem) {
    var $agenda = elem;

    $agenda.fullCalendar({
        defaultView: $agenda.data('view'),
        nextDayThreshold: "0" + calendarOverlapThreshold + ":00:01",
        fixedWeekCount: false,
        eventLimit: 3,
        lang: calendarLocale,
        views: viewSpecificOptions,
        firstDay: calendarFirstDayOfWeek,
        height: 500,
        scrollTime: moment().format('HH:mm:ss'),
        eventClick: eventClick,
        eventRender: function (event, element) {
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
        },
        events: function(start, end, timezone, callback)
        {
            var data = {
                dateRangeStart: start.toISOString(),
                dateRangeEnd: end.toISOString(),
                nonEditable: true,
                calendars: $agenda.data('calendars')
            };
            data[csrfTokenName] = csrfTokenValue;

            $.ajax({
                url: Craft.getCpUrl('calendar/month'),
                data: data,
                type: 'post',
                dataType: 'json',
                success: function (eventList) {
                    callback(eventList);
                }
            });
        },
        customButtons: {
            refresh: {
                text: Craft.t('Refresh'),
                click: function () {
                    $agenda.fullCalendar('refetchEvents');
                }
            }
        },
        header: {
            right: 'prev,today,next',
            left: 'title'
        }
    });
}
