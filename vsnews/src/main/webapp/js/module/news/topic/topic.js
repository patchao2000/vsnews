$(function() {

    // 签收
    $('.claim').button({
        icons: {
            primary: 'ui-icon-person'
        }
    });

    //    办理
    $('.handle').button({
        icons: {
            primary: 'ui-icon-comment'
        }
    }).click(handle);

    // 跟踪
//    $('.trace').click(graphTrace);

});

// 用于保存加载的详细信息
var detail = {};

/**
 * 加载详细信息
 * @param {Object} id
 */
function loadDetail(id, withVars, callback) {
    var dialog = this;
    $.getJSON(ctx + '/news/topic/detail/' + id, function(data) {
        detail = data;
        $.each(data, function(k, v) {

            // 格式化日期
            if (k == 'applyTime') {
                $('.view-info td[name=' + k + ']', dialog).text(new Date(v).format('yyyy-MM-dd hh:mm'));
            } else {
                $('.view-info td[name=' + k + ']', dialog).text(v);
            }

        });
        if ($.isFunction(callback)) {
            callback(data);
        }
    });
}

function complete(taskId, variables) {
    var dialog = this;

    // 转换JSON为字符串
    var keys = "", values = "", types = "";
    if (variables) {
        $.each(variables, function() {
            if (keys != "") {
                keys += ",";
                values += ",";
                types += ",";
            }
            keys += this.key;
            values += this.value;
            types += this.type;
        });
    }

    $.blockUI({
        message: '<h2><img src="' + ctx + '/images/ajax/loading.gif" align="absmiddle"/>正在提交请求……</h2>'
    });

    // 发送任务完成请求
    $.post(ctx + '/news/topic/complete/' + taskId, {
        keys: keys,
        values: values,
        types: types
    }, function(resp) {
        $.unblockUI();
        if (resp == 'success') {
            alert('任务完成');
            location.reload();
        } else {
            alert('操作失败!');
        }
    });
}

var handleOpts = {
    leaderAudit: {
        width: 300,
        height: 300,
        open: function (id) {

            // 打开对话框的时候读取请假内容
            loadDetail.call(this, id);
        },
        btns: [
            {
                text: '同意',
                click: function () {
                    var taskId = $(this).data('taskId');

                    // 设置流程变量
                    complete(taskId, [
                        {
                            key: 'leaderPass',
                            value: true,
                            type: 'B'
                        }
                    ]);
                }
            },
            {
                text: '驳回',
                click: function () {
                    var taskId = $(this).data('taskId');

                    $('<div/>', {
                        title: '填写驳回理由',
                        html: "<textarea id='leaderBackReason' style='width: 250px; height: 60px;'></textarea>"
                    }).dialog({
                        modal: true,
                        open: function () {

                        },
                        buttons: [
                            {
                                text: '驳回',
                                click: function () {
                                    var leaderBackReason = $('#leaderBackReason').val();
                                    if (leaderBackReason == '') {
                                        alert('请输入驳回理由！');
                                        return;
                                    }

                                    // 设置流程变量
                                    complete(taskId, [
                                        {
                                            key: 'leaderPass',
                                            value: false,
                                            type: 'B'
                                        },
                                        {
                                            key: 'leaderBackReason',
                                            value: leaderBackReason,
                                            type: 'S'
                                        }
                                    ]);
                                }
                            },
                            {
                                text: '取消',
                                click: function () {
                                    $(this).dialog('close');
                                    $('#leaderAudit').dialog('close');
                                }
                            }
                        ]
                    });
                }
            },
            {
                text: '取消',
                click: function () {
                    $(this).dialog('close');
                }
            }
        ]
    }
};

function handle() {
    // 当前节点的英文名称
    var tkey = $(this).attr('tkey');

    // 当前节点的中文名称
    var tname = $(this).attr('tname');

    // 记录ID
    var rowId = $(this).parents('tr').attr('id');

    // 任务ID
    var taskId = $(this).parents('tr').attr('tid');

    // 使用对应的模板
    $('#' + tkey).data({
        taskId: taskId
    }).dialog({
        title: '流程办理[' + tname + ']',
        modal: true,
        width: handleOpts[tkey].width,
        height: handleOpts[tkey].height,
        open: function() {
            handleOpts[tkey].open.call(this, rowId, taskId);
        },
        buttons: handleOpts[tkey].btns
    });
}

Date.prototype.format = function(format) {
    var o = {
        "M+": this.getMonth() + 1, //month
        "d+": this.getDate(), //day
        "h+": this.getHours(), //hour
        "m+": this.getMinutes(), //minute
        "s+": this.getSeconds(), //second
        "q+": Math.floor((this.getMonth() + 3) / 3), //quarter
        "S": this.getMilliseconds() //millisecond
    }
    if (/(y+)/.test(format))
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(format))
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
    return format;
}