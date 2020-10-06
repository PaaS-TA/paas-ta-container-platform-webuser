<%--
  Users main
  @author hrjin
  @version 1.0
  @since 2020.10.05
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.paasta.container.platform.web.user.common.Constants" %>
<div class="content">
    <div class="cluster_tabs clearfix"></div>
    <div class="cluster_content01 row two_line two_view">
        <ul>
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top user">
                        <p>Users</p>
                    </div>
                    <div class="view_table_wrap">
                        <div class="table-search-wrap">
                            <input type="text" id="table-search-01" name="" class="table-search user" placeholder="User ID" onkeypress="if(event.keyCode===13) {setUsersList(this.value);}" />
                            <button name="button" class="btn" id="userSearchBtn" type="button">
                                <i class="fas fa-search"></i>
                            </button>
                            <select class="user-filter" onchange="changeRoleSearch()">
                                <option selected>Total</option>
                                <option value="Administrator">Administrator</option>
                                <option value="Regular User">Regular User</option>
                                <option value="Init User">Init User</option>
                            </select>
                        </div>
                        <table class="table_event condition alignL user">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:20%;'>
                                <col style='width:20%;'>
                                <col style='width:30%;'>
                            </colgroup>
                            <thead>
                            <tr id="noResultArea" style="display: none;"><td colspan='4'><p class='user_p'>사용자가 존재하지 않습니다.</p></td></tr>
                            <tr id="resultHeaderArea">
                                <td>User ID</td>
                                <td>생성일</td>
                                <td>수정일</td>
                                <td>Role</td>
                            </tr>
                            </thead>
                            <tbody id="resultArea">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>

<script type="text/javascript">
    var G_USERS_LIST;
    var G_ROLE_SEARCH_NAME;

    var G_ADMIN_CODE = '<c:out value="${roleSetCodeList.administratorCode}" />';
    var G_REGULAR_USER_CODE = '<c:out value="${roleSetCodeList.regularUserCode}" />';
    var G_INIT_USER_CODE = '<c:out value="${roleSetCodeList.initUserCode}" />';

    var G_ADMIN_NAME = '<c:out value="${roleSetNameList.administratorName}" />';
    var G_REGULAR_USER_NAME = '<c:out value="${roleSetNameList.regularUserName}" />';
    var G_INIT_USER_NAME = '<c:out value="${roleSetNameList.initUserName}" />';

    // GET LIST
    var getUsersList = function() {
        procViewLoading('show');
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_USERS_LIST %>".replace("{namespace:.+}", "temp-namespace");

        procCallAjax(reqUrl, "GET", null, null, callbackGetUsersList);
    };


    // CALLBACK
    var callbackGetUsersList = function(data) {
        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            procAlertMessage();
            return false;
        }

        G_USERS_LIST = data.items;

        procViewLoading('hide');
        setUsersList("");
    };

    // SET LIST
    var setUsersList = function(searchKeyword) {
        procViewLoading('show');
        var userId;

        var resultArea = $('#resultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var noResultArea = $('#noResultArea');

        var items = [];

        for(var k = 0; k < G_USERS_LIST.length; k++){
            var rc = G_USERS_LIST[k].roleSetCode;

            if(rc === G_ADMIN_CODE){
                rc = G_ADMIN_NAME;
            }else if(rc === G_REGULAR_USER_CODE){
                rc = G_REGULAR_USER_NAME;
            }else{
                rc = G_INIT_USER_NAME;
            }


            var defaultSelectRole = $(".user-filter option:selected").val();

            if(defaultSelectRole === "Total" || G_ROLE_SEARCH_NAME === "Total"){
                items = G_USERS_LIST;
                break;
            }else if(G_ROLE_SEARCH_NAME === rc){
                items.push(G_USERS_LIST[k]);
            }
        }

        var listLength = items.length;

        var checkListCount = 0;
        var htmlString = [];

        var selectBox = '';

        for (var i = 0; i < listLength; i++) {
            var option = '';
            selectBox = '';
            userId = items[i].userId;

            if ((nvl(searchKeyword) === "") || userId.indexOf(searchKeyword) > -1) {
                htmlString.push(
                    "<tr>"
                    + "<td class='userId'>" + items[i].userId + "</td>"
                    + "<td>" + items[i].created + "</td>"
                    + "<td>" + items[i].lastModified + "</td>"
                    + "<td>" + "<select name='role-filter' data-user-id='"+ items[i].userId +"'></select>"
                    + "<span class='usersSaveRole'><i class='fas fa-save'></i></span>"
                    + "<span class='usersDeleteUser' ><i class='fas fa-trash-alt'></i></span>"
                    + "</td>"
                    + "</tr>");

                checkListCount++;
            }
        }

        if (listLength < 1 || checkListCount < 1) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
            resultArea.html(htmlString);
        }

        procViewLoading('hide');
    };

    // BIND (SERACH USER BUTTON)
    $("#userSearchBtn").on("click", function () {
        var keyword = $("#table-search-01").val();
        setUsersList(keyword);
    });


    // ON LOAD
    $(document.body).ready(function () {
        getUsersList();
    });

</script>