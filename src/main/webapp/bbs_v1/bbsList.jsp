<%@page import="net.utility.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../ssi.jsp" %>
<%@ include file="../header_bbs.jsp" %>
 <!-- 본문 시작 -->
	<div class="container">
	<h3 class="font2"> 게시판 </h3>

	<table class="table table-condensed context">
	<tr>
		<th class="col-xs-6" style="text-align: center;">제목</th>
		<th class="col-xs-3" style="text-align: center;">이름</th>
		<th class="col-xs-1" style="text-align: center;">조회수</th>
		<th class="col-xs-2" style="text-align: center;">작성일</th>
	</tr>
	
<%
	ArrayList<BbsDTO> list=dao.list();
	if(list==null){
		out.print("<tr>");
		out.print("	<td class='hg' colspan='5'>글없음!!</td>");
		out.print("</tr>");
	} else {
		
		// 오늘 날짜를 문자열 "2022-10-22"로 만들기
		String today = Utility.getDate();
		
		for(int idx=0; idx<list.size(); idx++){
			dto=list.get(idx);
						
%>
			<tr>
				<td class="col-xs-6"><a href="bbsRead.jsp?bbsno=<%=dto.getBbsno()%>">
<%
			//답변 이미지 출력
			for(int n=1; n<=dto.getIndent(); n++){
				out.print("<img src='../images/reply.gif'>");
			}
%>			
				<%=dto.getSubject()%></a>
<%
				
				// 오늘 작성한 글 제목 뒤에 new 이미지 출력
				// 작성일(regdt)에서 년월일만 자르기
				String regdt = dto.getRegdt().substring(0,10);
				if(regdt.equals(today)){
					out.print("<img src='../images/new.gif'>");
				}
				
				// 조회수가 10 이상이면 hot 이미지 출력
				if(dto.getReadcnt()>=10){
					out.print("<img src='../images/hot.gif'>");
				} // if end

%>			
				</td>
				<td class="col-xs-3"><%=dto.getWname()%></td>
				<td class="col-xs-1"><%=dto.getReadcnt()%></td>
				<td class="col-xs-2"><%=dto.getRegdt().substring(0,10)%></td>
			</tr>
<%
		} // for end
		
		// 글 갯수
		int totalRecord = dao.count();
		out.println("<tr>");
		out.println("	<td colspan='4' style='text-align:center;'>");
		out.println("		전체 글 : <strong>" + totalRecord + "</strong>");
		out.println("	<td>");
		out.println("</tr>");

		
	} // if end

%>
			
	</table>
	<p style="text-align: right;"><a class="btn btn-default hg" href="bbsForm.jsp">글쓰기</a></p>
	</div>
 <!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>