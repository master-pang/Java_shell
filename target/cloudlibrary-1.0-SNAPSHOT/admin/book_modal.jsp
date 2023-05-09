<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- 首页、当日预约情况 -->
<div class="modal fade" id="borrowModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="myModalLabel">请输入个人信息</h3>
            </div>
            <div class="modal-body">
                <form id="borrowBook">
                    <table class="table table-bordered table-striped" width="800px" >
                        <%--预约的id，不展示在页面--%>
<%--                        readonly只读--%>
                        <span><input type="hidden" id="bid" name="id"></span>
                        <tr>
                            <td>场所名称</td>
                            <td><input class="form-control" readonly name="name" id="bname"></td>
                            <td>手机号码</td>

                            <td><input class="form-control" placeholder="请输入11位手机号码" name="isbn" id="bisbn"></td>
                        </tr>
                        <tr>
                            <td>行李数</td>
                            <td><input class="form-control" placeholder="请输入行李数" name="press" id="bpress"></td>
                            <td>来访人数</td>
                            <td><input class="form-control" placeholder="请输入来访人数" name="author" id="bauthor"></td>
                        </tr>
                        <tr>
                            <td>离开时间<br/><span style="color: red">*</span></td>
                            <td>
                                <input class="form-control" id="time1" style="text-align: center;" name="returnTime" >
                            </td>

                    </table>
                </form>
            </div>
            <div class="modal-footer">
                <%--点击保存按钮时，隐藏模态窗口并调用js文件中的borrow()方法--%>
                <button class="btn btn-success" data-dismiss="modal" aria-hidden="true" onclick="borrow()"
                        id="savemsg1">预约
                </button>
                <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</button>
            </div>
        </div>
    </div>
</div>
<script>
    function show(){
        var tab = document.getElementById("test") ;
        //表格行数
        var rows = tab.rows.length ;
        //表格列数
        var cells = tab.rows.item(0).cells.length ;
        alert("行数"+rows+" ,列数"+cells);
    }


    function datetime() {
    var now = new Date();
    now.setDate(now.getDate() + 30)
    document.getElementById("time1").value = now.getFullYear() + "-"
        + (now.getMonth() + 1) + "-" + now.getDate();
    // document.getElementById("time1").value += " " + now.getHours() + ":"
    //     + now.getMinutes() + ":" + now.getSeconds();
}
window.setInterval("datetime()", 1000);
</script>