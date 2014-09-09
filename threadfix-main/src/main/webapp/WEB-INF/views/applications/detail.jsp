<%@ include file="/common/taglibs.jsp"%>

<head>
	<title><c:out value="${ application.name }"/></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/dyn-form.css"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/add-defect-tracker-modal-controller.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/application-detail-page-controller.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/application-page-modal-controller.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/defect-submission-modal-controller.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/modal-controller-with-config.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/reports-controller.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/scan-table-controller.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/upload-scan-controller.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/scheduled-scan-tab-controller.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/vuln-table-controller.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/document-form-controller.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/scan-agent-tasks-tab-controller.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/bulk-operations-controller.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/vuln-search-controller.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/scan-unmapped-finding-table-controller.js"></script>
</head>

<body ng-controller="ApplicationDetailPageController"
      ng-init="empty = <c:out value="${ numVulns }"/> === 0; numVulns = <c:out value="${numVulns}"/>"s
      ng-file-drop="onFileSelect($files)"
      ng-class="{ 'drag-enabled': dragEnabled }"
      id="apps">

    <%@ include file="/WEB-INF/views/angular-init.jspf"%>

    <div class="uploadable" style="padding-top:300px"><div style="opacity:1">Drop files anywhere to upload.</div></div>
    <div>

        <div id="headerDiv">
            <%@ include file="/WEB-INF/views/applications/detailHeader.jsp" %>
        </div>

        <div style="padding-top:10px;" id="helpText">
            Applications are used to store, unify, and manipulate scan results from security scanners.
            <c:if test="${ empty application.scans }">
                <br/><br/>To get started, click Upload Scan to start uploading security scans.
            </c:if>
        </div>

        <tabset style="margin-top:10px;">

            <tab id="vulnTrend" ng-controller="ReportsController" heading="Vulnerability Trending">
                <%@include file="vulnTrending.jsp"%>
            </tab>

            <tab id="topTen" ng-controller="ReportsController" heading="10 Most Occurring">
                <%@include file="topTen.jsp"%>
            </tab>

            <tab id="mit" ng-controller="MitigationProgressReport" heading="Mitigation">
                <%@include file="/WEB-INF/views/organizations/mitigationReport.jsp"%>
            </tab>
            <!--<tab id="report"  heading="Reports">
                <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/reports-controller.js"></script>
                <%@include file="reports.jspf"%>
            </tab> -->

        </tabset>


        <tabset style="margin-top:10px;">
            <%@ include file="/WEB-INF/views/applications/tabs/vulnTabTree.jsp" %>
            <%@ include file="/WEB-INF/views/applications/tabs/scanTab.jsp" %>
            <%@ include file="/WEB-INF/views/applications/tabs/docsTab.jsp" %>
            <%@ include file="/WEB-INF/views/applications/tabs/unmappedFindingsTab.jsp" %>
            <security:authorize ifAnyGranted="ROLE_CAN_MANAGE_SCAN_AGENTS">
                <c:if test="${isEnterprise}">
                    <tab id="scanAgentTasksTab" ng-controller="ScanAgentTasksTabController" heading="{{ heading }}">
                        <!-- TODO refactor this nesting -->
                        <c:if test="${ canManageApplications }">
                            <div style="margin-top:10px;margin-bottom:7px;">
                                <a id="addScanQueueLink" class="btn" ng-click="openNewScanAgentTaskModal()">Add New Task</a>
                            </div>
                        </c:if>

                        <%@ include file="/WEB-INF/views/applications/tabs/scanQueueTab.jsp" %>
                    </tab>
                    <tab id="scheduledScanTab" ng-controller="ScheduledScanTabController" heading="{{ heading }}">
                        <%@ include file="/WEB-INF/views/applications/tabs/scheduledScanTab.jsp" %>
                    </tab>
                </c:if>
            </security:authorize>
        </tabset>
    </div>

    <%@ include file="forms/uploadScanForm.jsp"%>
    <%@ include file="/WEB-INF/views/applications/forms/addWafForm.jsp" %>
    <%@ include file="/WEB-INF/views/wafs/forms/createWafForm.jsp" %>
    <%@ include file="/WEB-INF/views/applications/forms/addDTForm.jsp" %>
    <%@ include file="/WEB-INF/views/config/defecttrackers/modals/createDTModal.jsp" %>
    <%@ include file="/WEB-INF/views/config/users/permissibleUsers.jsp" %>
    <%@ include file="/WEB-INF/views/defects/submitDefectForm.jsp" %>
    <%@ include file="/WEB-INF/views/defects/mergeDefectForm.jsp" %>
    <%@ include file="/WEB-INF/views/applications/forms/vulnCommentForm.jsp"%>
    <%@ include file="/WEB-INF/views/applications/forms/uploadDocForm.jsp"%>
    <%@ include file="/WEB-INF/views/applications/forms/manualFindingForm.jsp"%>
    <%@ include file="/WEB-INF/views/applications/forms/addScheduledScanForm.jsp"%>
    <%@ include file="/WEB-INF/views/applications/forms/addScanQueueForm.jsp" %>
    <%@ include file="/WEB-INF/views/applications/forms/viewApplicationForm.jsp" %>
    <%@ include file="../scans/createMappingModal.jsp" %>
</body>