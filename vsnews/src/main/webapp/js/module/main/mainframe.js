// tabs
var $tabs = null;
var tabCounter = 1;
var lastMenuUrl = '';
var openedTabs = new Map();

$(function() {
	// 布局
	$('body').layout({
		north: {
			size: 47
		}
	});
	$('.ui-layout-resizer').addClass('ui-state-default');
	
	// 	init center pane
	var tabPanelHeight = $('#centerPane').height() - 35;
	$('#tab-index').height(tabPanelHeight);
	
	//	delegate close icon
	$('#tabs').tabs().delegate("span.ui-icon-close", "click", function() {
		var panelId = $(this).closest("li").remove().attr("aria-controls");
		$("#" + panelId).remove();
		$('#tabs').tabs("refresh");
		openedTabs.remove($(this).parent().find('a').text());
	});
	
	// 处理角色以及切换
	dealRoles();
	
});

function dealRoles() {
	openedTabs.put("首页", 0);
	
	$('#navimenu a').click(function() {
		if ($(this).attr('rel') == '#') {
			return true;
		}
		
		var tabTemplate = "<li><a class='tabs-title' href='#{href}'>#{label}</a>"
			+ "<span class='ui-icon ui-icon-close' title='关闭标签页'></span></li>";
		var tabs = $("#tabs").tabs();
			
		var moduleName = $(this).text();
		if (openedTabs.get(moduleName) == null) {
			var tabPanelHeight = $('#centerPane').height() - 35;
			lastMenuUrl = ctx + "/" + $(this).attr('rel');
			openedTabs.put($(this).text(), tabCounter);
			var id = "tabs-" + tabCounter;
			$('#' + id).css({height: tabPanelHeight + 'px', width: '100%'});
			var li = $(tabTemplate.replace(/#\{href\}/g, "#" + id).replace( /#\{label\}/g, moduleName));
			var tabContentHtml = "<iframe id='iframe" + tabCounter
				+ "' name='iframe" + tabCounter
				+ "' seamless class='module-iframe' style='width:100%;height:100%;'></iframe>";

			tabs.find(".ui-tabs-nav").append(li);
			tabs.append("<div id='" + id + "'>" + tabContentHtml + "</div>");
			$('#iframe' + tabCounter).attr('src', lastMenuUrl);
			tabs.tabs("refresh");
			
			$("#tabs").tabs("option", "active", tabCounter);
			tabCounter++;
			
		} 
		else {
			$("#tabs").tabs("option", "active", openedTabs.get(moduleName));
            lastMenuUrl = ctx + "/" + $(this).attr('rel');
            $('#iframe' + openedTabs.get(moduleName)).attr('src', lastMenuUrl);
		}
	});
    
}

