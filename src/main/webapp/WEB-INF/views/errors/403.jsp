<%--
  403 error page

  Created by IntelliJ IDEA.
  author: hrjin
  version: 1.0
  Date: 2020.11.13
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Container Platform</title>
    <style>
        .layer {position:absolute;display:table;top:0;left:0;width:100%;height:100%}
        .layer .layer_inner{display:table-cell;text-align:center;vertical-align:middle}
        .layer .content{display:inline-block;background:#fff;width: 28%; margin-top: -100px;}
        .panel {
            border: solid 1px #bbb;
        }
        .panel-heading {
            background-color: #2a6575; padding: 20px;
        }

        .panel-image {
            vertical-align: middle; margin-left: -20px;
        }
        .header-title {
            font-size: 16px;
            font-weight: 600;
            color: #dfe3e8;
            vertical-align:middle;
            margin-left: 6px;
        }
        .panel-body {
            padding: 40px;
        }
        .panel-body span {
            color: #343942;
        }
        hr {
            margin-top: 20px;
            margin-bottom: 20px;
            border: 0;
            border-top: 1px solid #ccc;
        }
    </style>
</head>
<body>
<div class="layer">
    <div class="layer_inner">
        <div class="content">
            <div class="panel" style="">
                <div class="panel-heading" style="">
                    <div>
                        <img  class="panel-image" src="/resources/images/main/logo.png" style="width: 60px; height: 48px;">
                        <span class="header-title" style=""> Container Platform </span>
                    </div>
                </div>

                <div class="panel-body" style="">
                    <span style="">페이지를 볼 수 있는 권한이 없습니다.</span>
                    <hr/>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>