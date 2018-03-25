$(function () {
    setTimeout(function () {
        var $eventCreator = $('.event-creator');
        var $allDay = $('.lightswitch', $eventCreator);
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

        $eventCreator.each(function () {
            var $context = $(this);

            $('ul.errors', $context).empty();

            var $startDate = $('input[name="startDate[date]"]', $context);
            var $startTime = $('input[name="startDate[time]"]', $context);
            var $endDate = $('input[name="endDate[date]"]', $context);
            var $endTime = $('input[name="endDate[time]"]', $context);

            $startTime.timepicker('option', 'step', calendarTimeInterval);
            $endTime.timepicker('option', 'step', calendarTimeInterval);

            $startDate.datepicker('option', 'onSelect', function (dateText) {
                $endDate.datepicker('option', 'minDate', dateText);
                $endDate.val(dateText);
            });

            $startTime.on('change', function () {
                var startDate = $startDate.datepicker('getDate');
                var endDate = $endDate.datepicker('getDate');

                var diffInDays = 0;
                if (startDate && endDate) {
                    diffInDays = Math.round((endDate - startDate) / (1000 * 60 * 60 * 24));
                }

                var currentTime = $startTime.timepicker('getTime');
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
            });

            $endDate.on('change', function () {
                $startTime.trigger('change');
            });


            var $allDayInput = $('input[name=allDay]', $context);
            var lightswitch = $allDayInput.parents('.lightswitch:first');

            lightswitch.data('lightswitch').turnOff();
            $('.timewrapper', $context).show();

            $(".btn.submit", $context).bind("click", function (e) {
                var title = $('input[name=title]', $context).val();
                var calendarId = $('select[name=calendarId]', $context).val();

                var startDateValue = moment($startDate.datepicker('getDate'));
                var startTimeValue = moment($startTime.timepicker('getTime'));
                var endDateValue = moment($endDate.datepicker('getDate'));
                var endTimeValue = moment($endTime.timepicker('getTime'));

                var isAllDay = $allDayInput.val();

                var startDateString = startDateValue.format('YYYY-MM-DD');
                var endDateString = endDateValue.format('YYYY-MM-DD');
                if (!isAllDay) {
                    startDateString = startDateString + ' ' + startTimeValue.format('HH:mm:ss');
                    endDateString = endDateString + ' ' + endTimeValue.format('HH:mm:ss')
                }

                var data = {
                    startDate: startDateString,
                    endDate: endDateString,
                    allDay: isAllDay,
                    event: {
                        title: title,
                        calendarId: calendarId
                    }
                };

                data[csrfTokenName] = csrfTokenValue;

                $('.spinner', $context).removeClass('hidden');
                $.ajax({
                    url: Craft.getCpUrl('calendar/events/api/create'),
                    type: 'post',
                    dataType: 'json',
                    data: data,
                    success: function (response) {
                        $('.spinner', $context).addClass('hidden');
                        if (response.error) {
                            $('ul.errors', $context)
                                .empty()
                                .append($('<li />', {text: response.error}));

                            Craft.cp.displayError(Craft.t('Couldn’t save event.'));
                        } else if (response.event) {
                            $('ul.errors', $context).empty();

                            $('input[type=text]', $context).val('');

                            Craft.cp.displayNotice(Craft.t('Event saved.'));
                        }
                    },
                    error: function (response) {
                        alert(response);
                    }
                });

                return false;
            });
        });
    }, 200);
});
