<%--
  Users role config page
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
                        <p>User Role Config</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL user">
                            <colgroup>
                                <col style='width:5%;'>
                                <col style='width:20%;'>
                                <col style='width:20%;'>
                                <col style='width:auto;'>
                                <col style='width:25%;'>
                            </colgroup>
                            <thead>
                            <tr id="noResultArea" style="display: none;"><td colspan='4'><p class='user_p'>사용자가 존재하지 않습니다.</p></td></tr>
                            <tr id="resultHeaderArea">
                                <td></td>
                                <td>User ID</td>
                                <td>Service Account</td>
                                <td>Role</td>
                                <td>Created time</td>
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
<div class="common-cu center">
    <button id="createBtn" type="button" class="colors8 common-btn" style="margin-right: 20px;">저장</button>
    <button id="cancel" type="button" class="colors5 common-btn" onclick="cancelBtn();">이전</button>
</div>

<script type="text/javascript">
    var G_USERS_LIST;
    var G_ROLES_LIST;
    var ROLE_SELECT_BOX_HTML;

    // GET LIST
    var getUsersList = function() {
        procViewLoading('show');
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_USERS_LIST %>";

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
        setUsersList();
    };

    // SET LIST
    var setUsersList = function() {
        procViewLoading('show');

        var resultArea = $('#resultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var noResultArea = $('#noResultArea');

        var listLength = G_USERS_LIST.length;

        var checkListCount = 0;
        var htmlString = [];

        var checkBox = '';

        for (var i = 0; i < listLength; i++) {
            if(NAME_SPACE === G_USERS_LIST[i].cpNamespace) {
                checkBox = "<input type='checkbox' style='opacity: 1; position: static' checked>"
            } else {
                checkBox = "<input type='checkbox' style='opacity: 1; position: static'>"
            }

            var selectRole = "<option>-----선택-----</option>";

            for(var j = 0; j < G_ROLES_LIST.length; j++) {
                var roleName = G_ROLES_LIST[j].metadata.name;

                if(roleName === G_USERS_LIST[i].roleSetCode) {
                    selectRole  += "<option selected value='" + roleName + "'" + "id='role" + j + "'>" + roleName + "</option>";
                } else {
                    selectRole  += "<option value='" + roleName + "'" + "id='role" + j + "'>" + roleName + "</option>";
                }
            }

            htmlString.push(
                "<tr>"
                + "<td>" + checkBox + "</td>"
                + "<td class='userId'>" + G_USERS_LIST[i].userId + "</td>"
                + "<td>" + G_USERS_LIST[i].serviceAccountName + "</td>"
                + "<td><select class='roleList'>" + selectRole + "</select></td>"
                + "<td>" + G_USERS_LIST[i].created + "</td>"
                + "</td>"
                + "</tr>");

            checkListCount++;

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

    };

    var getRolesList = function() {
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_ROLES_LIST %>".replace("{namespace:.+}", NAME_SPACE);
        procCallAjax(reqUrl, "GET", null, null, callbackGetRolesList);
    };

    var callbackGetRolesList = function (data) {
        G_ROLES_LIST = data.items;
        procViewLoading('hide');
    };


    var cancelBtn = function () {
        procMovePage(-1);
    };

    // ON LOAD
    $(document.body).ready(function () {
        // k8s에서 롤 목록 조회
        getRolesList();

        // DB에 있는 전체 user 목록 조회
        getUsersList();

    });

</script>