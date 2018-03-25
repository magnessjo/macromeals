$(function() {
  var $tabs = $('#fieldlayoutform > .fld-tabs');
  var $descriptionSelect = $("#descriptionFieldHandle");
  var $locationSelect = $("#locationFieldHandle");
  var lastUsedFieldCount = null;

  setInterval(function() {
    var fieldsUsed = [];
    var fields = $(".fld-tab .fld-field[data-id]", $tabs);

    if (fields.length === lastUsedFieldCount) {
      return;
    }

    fields.each(function() {
      var id = parseInt($(this).data("id"));

      if (fieldsUsed.indexOf(id) === -1 && customFieldData[id]) {
        fieldsUsed.push(id);
      }
    });

    lastUsedFieldCount = fields.length;

    var descriptionVal = $descriptionSelect.val();
    var locationVal = $locationSelect.val();
    $descriptionSelect.find("option:gt(0)").remove();
    $locationSelect.find("option:gt(0)").remove();
    for (var i = 0; i < fieldsUsed.length; i++) {
      var handle = customFieldData[fieldsUsed[i]].handle;
      var name   = customFieldData[fieldsUsed[i]].name;

      var $descriptionOption = $("<option>").html(name).attr("value", handle);
      var $locationOption    = $descriptionOption.clone();


      if (handle == descriptionVal) {
        $descriptionOption.attr("selected", "selected");
      }

      $descriptionSelect.append($descriptionOption);

      if (handle == locationVal) {
        $locationOption.attr("selected", "selected");
      }

      $locationSelect.append($locationOption);
    }
  }, 1000);
});
