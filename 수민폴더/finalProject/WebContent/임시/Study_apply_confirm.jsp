<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Study_apply_confirm.jsp</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>

<!-- ���� ������ CSS -->
<link rel="stylesheet" href="css/sumin/Layout.css">
<link rel="stylesheet" href="css/sumin/Study_apply.css">

<script type="text/javascript">

	function click_confirm() {
		
		var response = confirm("�ȳ������� ��� Ȯ���ϼ̽��ϱ�?");
		
		if (response) {
			window.location.href="Study_apply_complete.jsp";
		}
	}

</script>
</head>
<body>

<div class="wrapper">
	<jsp:include page="header.jsp" flush="false"/>
	<div class="main-content"><br>
		<div class="menu">
		<br><br> 
			<h1 class="text-center">���͵�</h1>
			<br><br><br>
			<nav>
				<ul>
					<li><a class="selected">���͵�</a></li>
					<li><a >���͵� ����</a></li>
				</ul>
			</nav>
		</div>

		<div class="content">
			<br>
			<p class="category">�Ʒ� �׸��� �ٽ� �� �� Ȯ�����ּ���.</p><br>
			<div class="tableDiv">
				<table class="table">		
					<tr>
						<th>���͵� �̸�</th>
						<td colspan="4" class="left">�ڹ� �߱� / ����Ŭ ���͵�</td>
					</tr>
					<tr>
						<th>������</th>
						<td>�����</td>
						<th>������</th>
						<td>2020 / 12 / 20</td>
					</tr>
					<tr>
						<th>���۳�¥</th>
						<td>2020 / 1 / 1</td>
						<th>���ᳯ¥</th>
						<td>2021 / 5 / 31</td>
					</tr>
					<tr>
						<th rowspan="2">Ƚ��</th>
						<td rowspan="2">2</td>
						<th rowspan="2" class="narrow">���� �� �ð�</th>
						<td>������ 13:00~15:00</td>
					</tr>
					<tr>	
						<td>������ 16:00~18:00</td>
					</tr>
					<tr>
						<th>���</th>
						<td colspan="5">����� ������</td>
					</tr>
					<tr>
						<th>�ȳ�����</th>
						<td colspan="5" class="left">x�� x�� ���͵� ���۵˴ϴ�. x�� x�� ���Ŀ� ���͵� ���� ��Ҹ� �ϰ� �Ǹ� �г�Ƽ�� �ֽ��ϴ�.
						<br>���͵� ���� ������ �ο��� ����ų� �ּ� �ο��� ���� ��� ������ ���͵���� �����Ͽ� ���͵� ����ϰ� �˴ϴ�.
						<br>�� ��쿡 ���õ��� �ʴ��� �г�Ƽ�� �ο����� �ʽ��ϴ�.
						<br>��� �ȳ����� ����
						</td>
					</tr>
				</table>
				</div>
				<div class="buttons">
					<button type="submit" class="btn btn-outline-primary" onclick="click_confirm()">��û�ϱ�</button>
					<button type="submit" class="btn btn-outline-primary">���ư���</button>
				</div>
			<br>
		</div>	
	</div>
	<jsp:include page="footer.jsp" flush="false"/>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
		
</body>
</html>