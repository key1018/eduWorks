<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- css  -->
<link href="${pageContext.request.contextPath}/resources/css/mail.css"
	rel="stylesheet" type="text/css">

</head>
<body>

	<!-- 은영 -->
	<jsp:include page="../common/header.jsp" />

	<!-- 공통요소 사이드 메뉴바(메일만 해당) -->
	<jsp:include page="commonMailMenu.jsp" />

	<!-- 메인 콘텐츠 영역 -->
	<div class="main-content">
		<div class="second-title">

 		<div>
			<c:if test="${flag == 'F' }">
				<i class='fas fa-bookmark' style="color:${m.tag.tagColor};" ></i>
			</c:if>
 				${text }
 			<span class="mail-count">전체메일 ${count } / 안읽은 메일 ${unread }</span>
 		</div>
		<input type="hidden" name="mailNo" id="detailFolder" value="${m.mailStatus.mailFolder }">
			<ul class="navbar-nav ml-auto moDelte">
				<li class="nav-item dropdown no-arrow mx-1">
					<button type="button" class="reply-btn">
						<i class="fas fa-location-arrow"></i>&nbsp;&nbsp;답장
					</button>
					<!-- 
					<button type="button" class="sub-btn">
						<i class="fas fa-arrow-right"></i>&nbsp;&nbsp;전달
					</button>
					 -->
					<button type="button" class="sub-btn" onclick="chooseDelete();">
						<i class="fas fa-trash-alt"></i>&nbsp;&nbsp;삭제
					</button>
					<button class="nav-link dropdown-toggle sub-btn tag-btn" href="#"
						id="dotDropdown" role="button" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-bookmark"></i>&nbsp;&nbsp;태그
					</button>
					<!--
					<button type="button" class="sub-btn warning-btn">
						<i class="fas fa-exclamation-triangle"></i>&nbsp;&nbsp;스팸신고
					</button>
					-->
					<div class="dropdown-list dropdown-menu shadow"
						aria-labelledby="dotDropdown" style="margin-top: -10px;">

					</div>
				</li>
			</ul>
		</div>

		<hr style="margin: 20px 0px 15px 0px;">

		<div class="send-form" id="mailForm">

			<div class="detail-form">

				<table>
					<tr>
						<th colspan="2">
							<h3 class="detail-title">
								<c:choose>
									<c:when test="${m.mailStatus.mailImportant == 'N' }">
										<span class="importCheck" 
											  onclick="importantBtn(${m.mailNo}, '${m.mailStatus.mailImportant }');">
										<i class="icon far fa-star"></i>
										</span>
									</c:when>
									<c:otherwise>
										<span class="importCheck" 
											  onclick="importantBtn(${m.mailNo}, '${m.mailStatus.mailImportant }');">
										<i class="icon fas fa-star" id="import"></i>
										</span>
									</c:otherwise>
								</c:choose>
								<span>
									<c:if test="${m.mailType == 1 }">
										<span style="color:red;">[중요!]</span>
									</c:if>
									<c:if test="${m.tagNo != '' }">
										<i class='fas fa-bookmark' style="color:${m.tag.tagColor};" ></i>
									</c:if>
									${m.mailTitle }
								</span>
							</h3>
						</th>
					</tr>
					
					<tr>
						<th>받는사람</th>
						<c:choose>
							<c:when test="${m.receiverMem == null}">
								<td>${m.receiverMem }</td>
							</c:when>
							<c:otherwise>
								<td>${m.receiverMem }</td>
							</c:otherwise>
						</c:choose>

					</tr>

					<tr>
						<th>참조</th>
						<c:choose>
							<c:when test="${m.ccMem == null }">
								<td>${m.ccMail }</td>
							</c:when>
							<c:otherwise>
								<td>${m.ccMem }</td>
							</c:otherwise>
						</c:choose>
					</tr>

					<tr>
						<th>보낸날짜</th>
						<td>${m.sendDate }</td>
					</tr>

				</table>
							
		<form id="postMailDetail" action="mailDetail.ma" method="post">
			<input type="hidden" name="mailNo" id="detailNo">
		</form>
		
		<script>
		
			// '중요메일' 설정시 실행하는 함수
			function importantBtn(mailNo, important){
	
				$.ajax({
					url : "updateImportant.ma",
					data : {
						mailNo : mailNo
					  , mailFolder : ${m.mailStatus.mailFolder}
					  , mailImportant : important
					},
					success : function(result){
						if(result == 'success'){
							location.reload();
						}
					},
					error : function(){
						console.log("좋아요 실패");
					}
				})
	
			}
			
			$(function(){
			
				// 메일 '답장'시 실행하는 함수
				$(".reply-btn").click(function(){

					$("#detailNo").val( ${m.mailNo} );
					$("#postMailDetail").attr("action", 'replyMail.ma').submit();
					})
					
			})
			
			// 메일 '삭제'시 실행하는 함수
			function chooseDelete(){

				let mailNo = $("#detailNo").val( ${m.mailNo} );
				let mailFolder = $("#detailFolder").val();
				let flag = '${flag}';
			
				$.ajax({
					url : "deleteMail.ma",
					data : {
						sendMail : '${loginUser.memEmail}',
						receiveMail : '${loginUser.memEmail}',
						mailNo : mailNo.val(),
						mailFolder : mailFolder
					},
					success : function(result){
						if(result == 'success'){
							switch(flag){
							case "A" : location.href="sendMailList.ma"; break; 
							}
						}	
					},
					error : function(){
						console.log("메일 삭제 실패");
					}
				})
			}

		
		</script>

				<div id="mail-file">
					<c:choose>
						<c:when test="${m.attachment.atCount > 0}">
							<!-- 첨부파일이 있는 경우 -->
							<c:forEach var="a" items="${at }">
								<a href="${a.atChangeName }" download="${a.atOriginName }">${a.atOriginName }</a>
								<br>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<!-- 첨부파일이 없는 경우 -->    	
							 첨부파일이 없습니다.
                        </c:otherwise>
					</c:choose>
				</div>

			</div>

			<div>
				<div class="mail-content">
					<input type="hidden" name="mailContent" value="${m.mailContent }">
					<div>

						<p>${m.mailContent }</p>

					</div>
				</div>
			</div>

		</div>

	</div>
	
	<jsp:include page="../common/footer.jsp" />
</body>
</html>