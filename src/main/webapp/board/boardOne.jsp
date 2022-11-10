<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>

<%
	// 1
	int boardNo=Integer.parseInt(request.getParameter("boardNo"));
	
	// 2
	Class.forName("org.mariadb.jdbc.Driver"); //요청처리
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees", "root", "java1234");
	
	String sql="SELECT board_title boardTitle, board_content boardContent, board_writer boardWriter, createdate FROM board WHERE board_no=?";
	PreparedStatement stmt=conn.prepareStatement(sql);
	stmt.setInt(1, boardNo);
	ResultSet rs=stmt.executeQuery();
	Board board=null;
	if(rs.next()) {
		board=new Board();
		board.boardNo=boardNo;
		board.boardTitle=rs.getString("boardTitle");
		board.boardContent=rs.getString("boardContent");
		board.boardWriter=rs.getString("boardWriter");
		board.createdate=rs.getString("createdate");
	}

	// 3



%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	
	<h1>게시글 상세보기</h1>
	<table border="1">
		<tr>
			<td>번호</td>
			<td><%=board.boardNo%></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><%=board.boardTitle%></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><%=board.boardContent%></td>
		</tr>
		<tr>
			<td>글쓴이</td>
			<td><%=board.boardWriter%></td>
		</tr>
		<tr>
			<td>생성날짜</td>
			<td><%=board.createdate%></td>
		</tr>
	</table>
		<a href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=boardNo%>">수정</a>
		<a href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%=boardNo%>">삭제</a>
</body>
</html>