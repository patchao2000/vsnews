var tabCounter = 1;
var lastMenuUrl = '';
var openedTabs = new Map();
//var currentTab;

$(function () {
    openedTabs.put("首页", 0);
    $("#tab-0").tab('show');

    $('#maintabs a').click(function (e) {
        e.preventDefault()

        $(this).tab('show')
//        $currentTab = $(this);
    });

    function registerCloseEvent() {
        $(".closeTab").click(function () {
            //  skip 'x'
            var moduleName = $(this).parent().text().substr(1);
//            alert(moduleName);
            if (openedTabs.get(moduleName) != null) {
                openedTabs.remove(moduleName);
            }

            //there are multiple elements which has .closeTab icon so close the tab whose close icon is clicked
            var tabContentId = $(this).parent().attr("href");
            $(this).parent().parent().remove(); //remove li of tab
            $('#maintabs a:last').tab('show'); // Select first tab
            $(tabContentId).remove(); //remove respective tab content

        });
    }

    $('#navimenu a').click(function () {
        if ($(this).attr('rel') == '#') {
            return true;
        }

        var tabTemplate = "<li><a id='#{id}' data-toggle='tab' href='#{href}'>" +
            "<button class='close closeTab' type='button'>×</button>#{label}</a></li>";
        var tabs = $("#maintabs");

        var moduleName = $(this).text();
        if (openedTabs.get(moduleName) == null) {
            lastMenuUrl = ctx + "/" + $(this).attr('rel');
            openedTabs.put($(this).text(), tabCounter);
            var id = tabCounter;
            var li = $(tabTemplate.replace(/#\{href\}/g, "#" + id).replace(/#\{label\}/g, moduleName).
                replace(/#\{id\}/g, "tab-" + id));
            var tabContentHtml = "<iframe id='iframe" + tabCounter
                + "' name='iframe" + tabCounter
                + "' seamless class='module-iframe' style='width:100%;height:100%;'></iframe>";

            tabs.find(".nav-tabs").append(li);
            tabs.find(".tab-content").append("<div class='tab-pane' id='" + id + "'>" + tabContentHtml + "</div>");
            $('#iframe' + tabCounter).attr('src', lastMenuUrl);
            $("#tab-" + id).tab('show');

            registerCloseEvent();

            tabCounter++;
        }
        else {
            $("#tab-" + openedTabs.get(moduleName)).tab('show');
        }
    });
});

