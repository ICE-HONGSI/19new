<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="operRightSystem">
	<div class="operRightTitle">
		<span>시스템 정보</span>
	</div>
	<div class="operSystemWrapper">
		<div>
			<h2 class="system_name" style="color: #ffffff">

				<%
					if (request.getAttribute("data") == "success")
						out.println("장비명 : " + request.getAttribute("Sname"));
					else
						out.println("  데이터가 없습니다.");
				%>

			</h2>
		</div>
		<table class="operPCSTable infoTable">
			<thead>
				<tr>
					<th class="pcs_item"><span>BMS</span></th>
					<th class="pcs_value"><span>IP 주소</span></th>
					<th class="pcs_item"><span>BMS</span></th>
					<th class="pcs_value"><span>IP 주소</span></th>
				</tr>
			</thead>
			<tbody>

				<%
					
					int add1 = 0;
					out.print("<script>console.log("+request.getAttribute("data")+");</script>");
					if (request.getAttribute("data") == "success") {
						Integer bms_cnt = (Integer) request.getAttribute("bms_cnt");
						if (bms_cnt == 0) {
							out.println("<td class='pcs_title1'>");
							out.println(" ");
							out.println("</td><td class='pcs_value1'>");
							out.println(" ");
							out.println("<td class='pcs_title1'>");
							out.println(" ");
							out.println("</td><td class='pcs_value1'>");
							out.println(" ");

						} else {
							for (int i = 0; i < bms_cnt; i++) {
								out.println("<td class='pcs_title1'>");
								out.println(i + 1);
								out.println("</td><td class='pcs_value1'>");
								out.println(request.getAttribute("BMS_IP" + Integer.toString(i + 1)));
								out.println("</td>");
								if (i == bms_cnt - 1 && (int) bms_cnt % 2 == 1) {
									out.println("<td class='pcs_title1'>");
									out.println(" ");
									out.println("</td><td class='pcs_value1'>");
									out.println(" ");
									out.println("</td>");
								} else if (i % 2 != 0)
									out.println("</tr>");
							}
						}
					} else
						add1 = 1;
					
					if(add1 == 1)
					{
						out.println("<td class='pcs_title1'>");
						out.println(" ");
						out.println("</td><td class='pcs_value1'>");
						out.println(" ");
						out.println("<td class='pcs_title1'>");
						out.println(" ");
						out.println("</td><td class='pcs_value1'>");
						out.println(" ");
					}
				%>
			</tbody>
		</table>

		<table class="operPCSTable infoTable">
			<thead>
				<tr>
					<th class="pcs_item"><span>PCS</span></th>
					<th class="pcs_value"><span>IP 주소</span></th>
					<th class="pcs_item"><span>PCS</span></th>
					<th class="pcs_value"><span>IP 주소</span></th>
				</tr>
			</thead>
			<tbody>
				<%
					int add2 = 0;
					if (request.getAttribute("data") == "success") {
						Integer pcs_cnt = (Integer) request.getAttribute("pcs_cnt");
						if (pcs_cnt == 1) {
							out.println("<td class='pcs_title1'>");
							out.println("1");
							out.println("</td><td class='pcs_value1'>");
							out.println(request.getAttribute("PCS_IP"));
							out.println("</td>");
							out.println("<td class='pcs_title1'>");
							out.println(" ");
							out.println("</td><td class='pcs_value1'>");
							out.println(" ");
							out.println("</td>");
						} else
							add2 = 1;
					} else
						add2 = 1;
					
					if(add2 == 1)
					{
						out.println("<td class='pcs_title1'>");
						out.println(" ");
						out.println("</td><td class='pcs_value1'>");
						out.println(" ");
						out.println("<td class='pcs_title1'>");
						out.println(" ");
						out.println("</td><td class='pcs_value1'>");
						out.println(" ");
					}
				%>
			</tbody>
		</table>


		<table class="operPCSTable infoTable">
			<thead>
				<tr>
					<th class="pcs_item"><span>EMU</span></th>
					<th class="pcs_value"><span>IP 주소</span></th>
					<th class="pcs_item"><span>EMU</span></th>
					<th class="pcs_value"><span>IP 주소</span></th>
				</tr>
			</thead>
			<tbody>
				<%
				int add3 = 0;
				if (request.getAttribute("data") == "success") {
					Integer emu_cnt = (Integer) request.getAttribute("emu_cnt");
					if (emu_cnt == 1) {
						out.println("<td class='pcs_title1'>");
						out.println("1");
						out.println("</td><td class='pcs_value1'>");
						out.println(request.getAttribute("EMU_IP"));
						out.println("</td>");
						out.println("<td class='pcs_title1'>");
						out.println(" ");
						out.println("</td><td class='pcs_value1'>");
						out.println(" ");
						out.println("</td>");
					} else
						add3 = 1;
				} else
					add3 = 1;
				
				if(add3 == 1)
				{
					out.println("<td class='pcs_title1'>");
					out.println(" ");
					out.println("</td><td class='pcs_value1'>");
					out.println(" ");
					out.println("<td class='pcs_title1'>");
					out.println(" ");
					out.println("</td><td class='pcs_value1'>");
					out.println(" ");
				}
				%>
			</tbody>
		</table>


		<table class="operPCSTable infoTable">
			<thead>
				<tr>
					<th class="pcs_item"><span>DPM</span></th>
					<th class="pcs_value"><span>IP 주소</span></th>
					<th class="pcs_item"><span>DPM</span></th>
					<th class="pcs_value"><span>IP 주소</span></th>

				</tr>
			</thead>
			<tbody>
				<tr>
					<%
						int add4 = 0;
						if (request.getAttribute("data") == "success") {

							Integer dpm_cnt = (Integer) request.getAttribute("dpm_cnt");
							if (dpm_cnt != 0) {
								for (int i = 0; i < dpm_cnt; i++) {
									out.println("<td class='pcs_title1'>");
									out.println(i + 1);
									out.println("</td><td class='pcs_value1'>");
									out.println(request.getAttribute("DPM_IP" + Integer.toString(i + 1)));
									out.println("</td>");
									if (i == dpm_cnt - 1 && (int) dpm_cnt % 2 == 1) {
										out.println("<td class='pcs_title1'>");
										out.println(" ");
										out.println("</td><td class='pcs_value1'>");
										out.println(" ");
										out.println("</td>");
									} else if (i % 2 != 0)
										out.println("</tr>");
								}

							} else
								add4 = 1;
						} else
							add4 = 1;

						if (add4 == 1) {
							out.println("<td class='pcs_title1'>");
							out.println(" ");
							out.println("</td><td class='pcs_value1'>");
							out.println(" ");
							out.println("<td class='pcs_title1'>");
							out.println(" ");
							out.println("</td><td class='pcs_value1'>");
							out.println(" ");
						}
					%>
				</tr>
			</tbody>
		</table>
	</div>
</div>