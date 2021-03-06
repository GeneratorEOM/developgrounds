<%@page import="board.file.FileBoardBean"%>
<%@page import="board.file.FileBoardDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<!--
Design by TEMPLATED
http://templated.co
Released for free under the Creative Commons Attribution License

Name       : Skeleton 
Description: A two-column, fixed-width design with dark color scheme.
Version    : 1.0
Released   : 20130902

-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=East+Sea+Dokdo&display=swap" rel="stylesheet">
<link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />
<!-- <link href="../css/info.css" rel="stylesheet" type="text/css" media="all" /> -->

<style type="text/css">



.table_wrap{
	
	width: 750px;
    margin:50px auto 0 auto;
    margin-bottom: 20px;
    line-height: 30px;
    font-size: 11pt;


}
.table_wrap, .table_wrap tr, .table_wrap td {

	border: 1px solid;
	border-width: 1px 0;
	border-collapse: collapse;
	text-align: center;
}

.table_wrap th{
		
		 
         background-color: #EAEAEA;
         color: black;
         border-width:2px 0;
}



.table_wrap a:hover {
		
		display: inline-block;	
		text-decoration: underline;

}
.table_wrap subject {

	width: 200px;
	color: black;
}
.table_wrap a {
	text-decoration: none;
	color: black;
}
.table_wrap th.tno {
	width: 50px;
}
.table_wrap th.ttitle {

	width: 300px;
}
.table_wrap th.twrite {
	text-align: left;
	width: 70px;
}
.table_wrap th.tdate {
	width: 70px;
}
.table_wrap th.tread {
	width: 50px;
}
.table_wrap th.tup {
	width: 50px;
}
.table_wrap th.file {
	width: 60px;
}
.table_wrap td.left01 {
	text-align: left;
}

#buttons .submit{

	height: 30px; width: 110px; border: 1px solid;
	font-size: 15px;
	font-weight: bold;
	margin-top: 0;
	margin-left: 345px;
	margin-bottom: 30px;
	background-repeat: repeat-x;
	background-position: center center;
}
#page_control{text-align: center; margin: 20px 0 30px 0;
margin-right: auto;margin-left: auto;}
/*글자정렬 center 밖여백 20px 0 0 0
밖여백오른쪽 auto 밖여백왼쪽 auto*/
#page_control a{padding: 2px 5px; text-decoration: none;
color: #333; margin: 0 5px;}
/*안여백 2px 5px 밑줄 none 글자색#333 밖여백 0 5px*/
#page_control a:hover{ color: #F90;
text-decoration: underline;}

</style>


<!--[if IE 6]><link href="default_ie6.css" rel="stylesheet" type="text/css" /><![endif]-->
<script type="text/javascript">

function write2(id) {
	
	if(id=='null') {
		alert("로그인 후 이용하세요.")
		return false
	}
	
	location.href='writeForm.jsp'
	

}
function down() {
	if(<%=session.getAttribute("id")%>==null) {
		alert("로그인 후 이용하세요.")
		return false
	}
}
</script>
</head>

<body>
<%
	String id = (String)session.getAttribute("id");
%>
<div id="page" class="container">
<jsp:include page="../inc/top.jsp" />
	<div id="main">
			<img src="../images/main2.png" alt="" class="image-full" />
		<div id="welcome">
			<div class="title">
				<h2 style="margin-bottom: 20px;">자료게시판</h2>
				<span class="byline"><b>다양한 개발자들과 자유롭게 소통할 수 있습니다 :)</b></span>
			</div>
		</div>
		

<%
			FileBoardDAO bdao = new FileBoardDAO();

				//게시판글개수 getBoardCount() count(*) 호출
				//int count = getBoardCount();

				int count = bdao.getBoardCount();

				//한 화면에 보여줄 가져올 글 개수 설정
				int pageSize = 10;

				//현 페이지 번호 가져오기 pageNum 파라미터 가져오기

				String pageNum = request.getParameter("pageNum");
				//현페이지 번호가 없으면 "1" 페이지로 설정

				if(pageNum==null) {
					pageNum = "1";
				}

				//10개씩 잘라서 1페이지 시작하는 행번호 구하기

				int currentPage = Integer.parseInt(pageNum);
				//10개씩 잘라서 1페이지 시작하는 행번호 구하기
				//pageNum(currentPage) 		pageSize		startRow 시작행번호
				//			1						10				1
				//			2						10				11
				//			3						10				21
				//			4						10				31
				int startRow = (currentPage-1)*pageSize+1;
				int endRow = currentPage*pageSize;


				//List boardList = bdao.getBoardList(시작하는행번호, 글개수);
				//select * from board order by num desc limit 시작하는행번호-1, 글개수
				List boardList = bdao.getBoardList(startRow, pageSize);
		%>
<table class="table_wrap">
<tr class="table01"><th class="tno">번호</th><th class="ttitle">제목</th><th class="twrite">작성자</th><th class="tdate">날짜</th><th class="tread">조회수</th><th class="tup">추천수</th><th class="file">다운로드</th></tr>

<%
	int num = count-((currentPage-1)*pageSize);
	for(int i=0;i<boardList.size();i++ ) {
		// 한칸의 정보 가져오기
		FileBoardBean bb = (FileBoardBean)boardList.get(i);
%>
		<tr>
		<td><%=num-- %> </td>
		<td class="left01"><a href="content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>"><%=bb.getSubject()%></a></td>
		<td class="left01"><%=bb.getId()%></td>
		<td><%=bb.getDate()%></td>
		<td><%=bb.getReadcount()%></td>
		<td><%=bb.getBoard_like() %></td>
		<td><a href="file_down.jsp?file_name=<%=bb.getFile() %>" onclick="return down()"><img src="../images/down.png" width="20" height="20"></a></td>
		</tr>
		<%
		
	
	}

	
%>
</table>

<form action="fileBoardSearch.jsp" method="post" style="margin-left: 530px; margin-bottom: 20px;">
<input type="text" name="search" class="input_box">
<input type="submit" value="제목검색" class="btn">
</form>

<div id="buttons">
<input type="button" value="글쓰기" onclick="return write2('<%=id %>')" class="submit">
</div>
<div id="page_control">
<%
// 전체 페이지수 구하기 전체 글 개수 50	한화면에 보여줄 글 개수 10 => 전체페이지수 5 + 나머지없으면0 => 5
//									 59							10 =>			   5 +		 있으면1 => 6
int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1);
// 한화면에 보여줄 페이지 개수
int pageBlock=10;
// 한화면에 보여줄 시작페이지 번호 구하기
// 페이지번호 currentPage			pageBlock			시작페이지 번호 startPage
//			1~10						10		  =>			1
//			11~20						10		  =>			11
//			21~30						10		  =>			21
int startPage = (currentPage-1)/pageBlock*pageBlock+1;


// 한화면에 보여줄 끝페이지 번호 구하기
// startPage		pageBlock		endPage
//		1				10		=>	10
//		11				10		=>	20
//		21				10		=>	30
int endPage=startPage+pageBlock-1;
//  endPage 10  <=  전체 페이지수 5페이지
if(endPage > pageCount){
	endPage=pageCount;
	
}
if(startPage > pageBlock){
	%>
	<a href="list.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a> <%
}

//1~ 10  11~20   startPage  ~ endPage
for(int i=startPage;i<=endPage;i++){
	%> <a href="list.jsp?pageNum=<%=i%>" class="pageNum"><%=i%></a> <%
}

//[다음] 10페이지 다음
if(endPage < pageCount){
	%> <a href="list.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a> <%
}
%>
</div>
<jsp:include page="../inc/bottom.jsp"/>
	</div>
	</div>
</body>
</html>