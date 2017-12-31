$(function() {
  $("a.enable-ics[data-calendar-id]").on({
    click: function() {
      if (!confirm(Craft.t("Are you sure you want to enable ICS sharing for this calendar?"))) {
        return false;
      }

      var $self = $(this);
      var calendarId = $self.data("calendar-id");
      var data = {
        calendar_id: calendarId,
      };

      data[Craft.csrfTokenName] = Craft.csrfTokenValue;

      Craft.postActionRequest(
        "calendar/calendars/enableIcsSharing",
        data,
        function(response) {
          if (!response.errors) {
            window.location.reload();
          } else {
            alert(response.errors.join(". "));
          }
        }
      );
    }
  });

  $("a.copy-ics-link[data-link]").on({
    click: function() {
      var link = $(this).data("link");
      var message = Craft.t('{ctrl}C to copy.', {
        ctrl: (navigator.appVersion.indexOf('Mac') ? '⌘' : 'Ctrl-')
      });

      prompt(message, link);
    }
  })

  $("a.disable-ics[data-calendar-id]").on({
    click: function() {
      if (!confirm(Craft.t("Are you sure you want to disable ICS sharing for this calendar?"))) {
        return false;
      }

      var $self = $(this);
      var calendarId = $self.data("calendar-id");
      var data = {
        calendar_id: calendarId,
      };

      data[Craft.csrfTokenName] = Craft.csrfTokenValue;

      Craft.postActionRequest(
        "calendar/calendars/disableIcsSharing",
        data,
        function(response) {
          if (!response.errors) {
            window.location.reload();
          } else {
            alert(response.errors.join(". "));
          }
        }
      );
    }
  });
});
