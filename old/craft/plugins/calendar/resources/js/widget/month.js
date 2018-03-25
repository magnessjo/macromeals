function initiateMiniCal(elem) {
    var miniCal = elem;

    miniCal.fullCalendar({
        defaultView: "month",
        nextDayThreshold: "0" + calendarOverlapThreshold + ":00:01",
        fixedWeekCount: false,
        eventLimit: 1,
        firstDay: calendarFirstDayOfWeek,
        height: "auto",
        columnFormat: "dd",
        viewRender: updateDayNumberDimensions,
        windowResize: updateDayNumberDimensions,
        eventClick: eventClick,
        dayClick: function(date, event, view) {
            window.location.href = Craft.getCpUrl('calendar/view/day/' + date.format("YYYY/MM/DD"));
        },
        events: function(start, end, timezone, callback)
        {
            var data = {
                dateRangeStart: start.toISOString(),
                dateRangeEnd: end.toISOString(),
                nonEditable: true,
                calendars: miniCal.data('calendars')
            };
            data[csrfTokenName] = csrfTokenValue;

            $.ajax({
                url: Craft.getCpUrl('calendar/month'),
                data: data,
                type: 'post',
                dataType: 'json',
                success: function (eventList) {
                    $(".fc-content-skeleton .fc-day-number.fc-has-event").removeClass("fc-has-event")
                    $.each(eventList, function(i, event) {
                        var start = moment(event.start);
                        var end = moment(event.end);

                        if (event.allDay) {
                            end.subtract('1', 'days');
                        }

                        while (start.isBefore(end)) {
                            $(".fc-content-skeleton .fc-day-number[data-date=" + start.utc().format("YYYY-MM-DD") + "]")
                                .addClass("fc-has-event");

                            start.add(1, 'days');
                        }
                    });
                }
            });
        },
        header: {
            left: 'prev',
            center: 'title',
            right: 'next'
        }
    });
}

function updateDayNumberDimensions(view, element) {
    var $skeleton = $(".fc-content-skeleton", element);

    $('.fc-day-number', element).css({
        textAlign: "center",
        padding: 0,
        minHeight: $skeleton.height() + "px",
        lineHeight: $skeleton.height() + "px"
    });
}
