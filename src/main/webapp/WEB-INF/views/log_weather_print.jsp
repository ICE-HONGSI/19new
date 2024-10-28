<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Weather API call date</title>
</head>
<body>
	<%
		BufferedReader br = null;
		String pathSet = "";
		try {
			if (request.getAttribute("d") == null) {
				Date today = new Date();
				SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");
				pathSet = request.getSession().getServletContext()
						.getRealPath("/WEB-INF/views/log_weather/" + format1.format(today) + "_logs.txt");
			} else
				pathSet = request.getSession().getServletContext()
						.getRealPath("/WEB-INF/views/log_weather/" + request.getAttribute("d") + "_logs.txt");

			br = new BufferedReader(new FileReader(pathSet));
			String line = "";

			while ((line = br.readLine()) != null) {
				out.println(line + "<br />");
			}
		} catch (Exception e) {
			out.println("로그 기록이 없습니다! <br />날짜를 다시 확인해주세요.");
		} finally {
			if (br != null)
				try {
					br.close();
				} catch (IOException e) {
				}

		}
	%>
</body>
</html>